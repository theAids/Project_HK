﻿using Project_HK.Models.EntityModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Project_HK.Models.DbManager
{
    public class AccountManager
    {
        public static void CreateAccountsTable()
        {
            using(SqlConnection conn = DbConnManager.GetDbConnection("AccountConnection"))
            {
                using(SqlCommand cmd = conn.CreateCommand())
                {
                    conn.Open();
                    string cmdstr = @"IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'users')
                                        CREATE TABLE[dbo].[users] (
                                            [userID] [bigint] NOT NULL PRIMARY KEY,
                                            [username] [varchar](20) NOT NULL UNIQUE,
                                            [password] [varchar](40) NOT NULL,
                                            [salt] [varchar](40) NOT NULL,
                                            [firstname] [varchar](20) NOT NULL,
                                            [lastname] [varchar](20) NOT NULL,
                                            [version] rowversion)";
                    cmd.CommandText = cmdstr;
                    cmd.Prepare();

                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception e)
                    {
                        Debug.WriteLine("SQL ERROR: " + e.Message);
                    }
                }
            }
        }

        public static string GetUsername(string username)
        {
            using(SqlConnection conn = DbConnManager.GetDbConnection("AccountConnection"))
            {
                using(SqlCommand cmd = conn.CreateCommand())
                {
                    conn.Open();

                    string cmdstr = "SELECT username from users WHERE username=@username";
                    cmd.CommandText = cmdstr;

                    cmd.Parameters.Add(new SqlParameter("@username", SqlDbType.VarChar, 20));
                    cmd.Prepare();

                    cmd.Parameters["@username"].Value = username;

                    try
                    {
                        return cmd.ExecuteScalar().ToString();
                    }
                    catch(Exception e)
                    {
                        Debug.WriteLine("SQL ERROR: " + e.ToString());
                        return null;
                    }
                }
            }
        }

        public static long GetLastID(int roleID)
        {
            using(SqlConnection conn = DbConnManager.GetDbConnection("AccountConnection"))
            {
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    conn.Open();

                    string cmdstr = "SELECT MAX(userID) FROM users WHERE userID/1000 = @roleID";
                    cmd.CommandText = cmdstr;
                    cmd.Parameters.Add(new SqlParameter("@roleID", SqlDbType.Int));
                    cmd.Prepare();

                    cmd.Parameters["@roleID"].Value = roleID;

                    try
                    {
                        var result = cmd.ExecuteScalar();
                        long id = Convert.ToInt64(result ?? default(long)); //default of long is 0L if null
                        return id;
                    }
                    catch(Exception e)
                    {
                        Debug.WriteLine("DB QUERY ERROR: " + e.Message);
                        return 0;
                    }
                }
            }
        }

        public static Boolean AddUser(long userID, string username, string firstname, string lastname, string password)
        {
            using(SqlConnection conn = DbConnManager.GetDbConnection("AccountConnection"))
            {
                using(SqlCommand cmd = conn.CreateCommand())
                {
                    conn.Open();

                    string cmdstr = "INSERT INTO users(userID, username, password, salt, firstname, lastname) VALUES(@userID, @username, @password, @salt, @firstname, @lastname)";
                    cmd.CommandText = cmdstr;

                    cmd.Parameters.Add(new SqlParameter("@userID", SqlDbType.BigInt));
                    cmd.Parameters.Add(new SqlParameter("@username", SqlDbType.VarChar, 20));
                    cmd.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar, 40));
                    cmd.Parameters.Add(new SqlParameter("@salt", SqlDbType.VarChar, 40));
                    cmd.Parameters.Add(new SqlParameter("@firstname", SqlDbType.VarChar, 20));
                    cmd.Parameters.Add(new SqlParameter("@lastname", SqlDbType.VarChar, 20));

                    cmd.Prepare();
                    cmd.Parameters["@userID"].Value = userID;
                    cmd.Parameters["@username"].Value = username;
                    cmd.Parameters["@firstname"].Value = firstname;
                    cmd.Parameters["@lastname"].Value = lastname;

                    string salt = GetSalt();
                    string hashPassword = HashPassword(password, salt);
                    cmd.Parameters["@salt"].Value = salt;
                    cmd.Parameters["@password"].Value = hashPassword;

                    try
                    {
                        cmd.ExecuteNonQuery();
                        return true;
                    }
                    catch(Exception e)
                    {
                        Debug.WriteLine("DB QUERY ERROR: " + e.ToString());
                        return false;
                    }

                }
            }
        }

        public static UserAccountModel ValidateUser(string username, string password)
        {
            using (SqlConnection conn = DbConnManager.GetDbConnection("AccountConnection"))
            {
                conn.Open();
                string salt = "";
                
                // get the corresponding salt for the user
                using (SqlCommand cmdPass = conn.CreateCommand())
                {
                    string cmdstr = "SELECT salt FROM users WHERE username=@username";
                    cmdPass.CommandText = cmdstr;
                    cmdPass.Parameters.Add(new SqlParameter("@username", SqlDbType.VarChar, 20));
                    cmdPass.Prepare();

                    cmdPass.Parameters["@username"].Value = username;

                    try
                    {
                        salt = cmdPass.ExecuteScalar().ToString();
                    }
                    catch (Exception e)
                    {
                        Debug.WriteLine("DB QUERY ERROR: " + e.Message);
                    }

                }

                // get username, lastname and firstname (if exists) for the cookies
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    string cmdstr = "SELECT username, lastname, firstname FROM users WHERE username=@username and password=@password";
                    cmd.CommandText = cmdstr;
                    cmd.Parameters.Add(new SqlParameter("@username", SqlDbType.VarChar, 20));
                    cmd.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar, 50));
                    cmd.Prepare();

                    cmd.Parameters["@username"].Value = username;
                    cmd.Parameters["@password"].Value = GetHash(password, salt);    // generate the hashed password w/ salt

                    UserAccountModel user = new UserAccountModel();

                    try
                    {
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                user.username = reader[0].ToString();
                                user.lastname = reader[1].ToString();
                                user.firstname = reader[2].ToString();

                                return user;
                            }
                        }
                        else
                            return null;
                    }
                    catch (Exception e)
                    {
                        Debug.WriteLine("DB QUERY ERROR: " + e.Message);
                    }

                }
            }

            return null;
        }


        /*************** Password Functions *****************************/
        public static string HashPassword(string pword, string salt)
        {
            pword += salt;

            MD5 md5hasher = MD5.Create();

            byte[] hashPword = md5hasher.ComputeHash(Encoding.ASCII.GetBytes(pword));

            StringBuilder strbuilder = new StringBuilder();

            // convert to bytes to hex
            for (int i = 0; i < hashPword.Length; i++)
            {
                strbuilder.Append(hashPword[i].ToString("x2")); 
            }

            return strbuilder.ToString();
        }

        public static string GetSalt()
        {
            using (RNGCryptoServiceProvider rngCsp = new RNGCryptoServiceProvider())
            {
                byte[] rand = new byte[32]; // create 32 character for salt. length is the same as the output of md5hash (recommended length)
                rngCsp.GetNonZeroBytes(rand);   // generate random values
                string saltStr = Encoding.ASCII.GetString(rand, 0, rand.Length);
                return saltStr;
            }
        }

        protected static string GetHash(string password, string salt)
        {
            password += salt;   // concatenate password and salt before hashing

            MD5 md5hasher = MD5.Create();

            byte[] hashPword = md5hasher.ComputeHash(Encoding.ASCII.GetBytes(password));    // compute for hash

            // convert the computed hash to hexadecimal
            StringBuilder strbuilder = new StringBuilder();

            for (int i = 0; i < hashPword.Length; i++)
            {
                strbuilder.Append(hashPword[i].ToString("x2"));
            }

            return strbuilder.ToString();
        }
    }
}