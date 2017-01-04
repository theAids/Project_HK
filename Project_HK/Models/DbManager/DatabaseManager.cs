using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Web;
using System.Xml;

namespace Project_HK.Models.DbManager
{
    public class DatabaseManager
    {
        public static XmlDocument ExtractPeopleData()
        {
            using (SqlConnection conn = DbConnManager.GetDbConnection("PeopleConnection"))
            {
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    conn.Open();
                    string cmdstr = "SELECT * FROM people FOR XML AUTO, ELEMENTS, XMLSCHEMA";
                    cmd.CommandText = cmdstr;
                    cmd.Prepare();

                    try
                    {
                        using (XmlReader reader = cmd.ExecuteXmlReader())
                        {
                            return GenerateXMLDoc(reader, "peopledata");    //returns the generated XML document
                        }
                    }
                    catch (Exception e)
                    {
                        Debug.WriteLine("XML Read Error: " + e.Message);
                        return null;
                    }
                }

            }
        }

        public static XmlDocument ExtractTimeData()
        {
            using (SqlConnection conn = DbConnManager.GetDbConnection("TimeConnection"))
            {
                using (SqlCommand cmd = conn.CreateCommand())
                {
                    conn.Open();
                    string cmdstr = "SELECT * FROM time FOR XML AUTO, ELEMENTS, XMLSCHEMA";
                    cmd.CommandText = cmdstr;
                    cmd.Prepare();

                    try
                    {
                        using (XmlReader reader = cmd.ExecuteXmlReader())
                        {
                            return GenerateXMLDoc(reader, "timedata");
                        }
                    }
                    catch (Exception e)
                    {
                        Debug.WriteLine("XML Read Error: " + e.Message);
                        return null;
                    }
                }
            }


        }

        private static XmlDocument GenerateXMLDoc(XmlReader reader, string rootName)
        {
            StringBuilder sb = new StringBuilder();

            //create header and root name for the xml document
            sb.AppendLine("<?xml version=\"1.0\" encoding=\"UTF - 8\"?>");
            sb.AppendLine(String.Format("<{0}>", rootName));


            /* refererence code for parsing xml
             * http://stackoverflow.com/questions/26787765/xmlreader-skips-elements
             */

            reader.Read();
            while (!reader.EOF)
            {
                if (reader.NodeType == XmlNodeType.Element) // check xml for each element occurence. 
                    sb.Append(reader.ReadOuterXml());
                else
                    reader.Read();
            }

            sb.AppendLine(string.Format("</{0}>", rootName));   // append the root end tag

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(sb.ToString());
            return doc;
        }
    }
}