using Project_HK.Models.EntityModels;
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