using KoalaGo.Data;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Data;
using System.Text.RegularExpressions;
using System.Web.Services;
using System.Xml;

namespace KoalaGo
{
    public partial class Map : System.Web.UI.Page
    {
        private static String val;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }

        //get koala information from data base and pass it to front end
        [WebMethod]
        public static string getKoalaOrganisations()
        {
            DataManager dm = new DataManager();
            DataTable dt = dm.getKoalaOrganisations();

            string result = JsonConvert.SerializeObject(dt);

            return result;
        }

        [WebMethod]
        public static string displayPastFireInformation(String date1)
        {
            DataManager dm = new DataManager();
            DataTable dt = dm.getHistoricFires(date1);

            string result = JsonConvert.SerializeObject(dt);

            return result;
        }

        //get koala information from database and pass it to front end

        [WebMethod]
        public static string getKoalaInfo()
        {
            DataManager dm = new DataManager();
            DataTable dt = dm.getKoalaHabitat_basedon_datefound();

            string result = JsonConvert.SerializeObject(dt);

            return result;
        }

        //get fire information from QA Fire RSS feed and capture relevent information and pass it to front end
        [WebMethod]
        public static string getFiresQA()
        {
            XmlDocument doc = new XmlDocument();

            doc.Load("https://www.qfes.qld.gov.au/data/alerts/bushfireAlert.xml");
            XmlNodeList nlist = doc.ChildNodes;

            XmlNodeList elemList = doc.GetElementsByTagName("entry");
            String result = "";
            ArrayList arr = new ArrayList();
            DataTable table = new DataTable();
            table.Columns.Add("lat", typeof(string));
            table.Columns.Add("lon", typeof(string));
            table.Columns.Add("date", typeof(string));

            table.Columns.Add("alerttype", typeof(string));
            table.Columns.Add("reported", typeof(string));
            table.Columns.Add("status", typeof(string));
            table.Columns.Add("details", typeof(string));
            table.Columns.Add("state", typeof(string));

            foreach (XmlNode xn in elemList)
            {
                XmlDocument content = new XmlDocument();

                XmlNode n = xn.LastChild;

                XmlNodeList tlist = xn.ChildNodes;

                String lat = n.InnerText.Split(' ')[0];
                String lon = n.InnerText.Split(' ')[1];
                DateTime s = Convert.ToDateTime(tlist[5].InnerText.ToString());

                String date1 = tlist[5].InnerText.Substring(0, 10);

                String desc = tlist[1].InnerText;

                string[] lines = Regex.Split(desc, "\n");

                String alerttype = lines[0].Split(':')[1];
                String reported = lines[1].Split(':')[1];
                String status = lines[2].Split(':')[1];
                String details = lines[3].Split(':')[1];

                table.Rows.Add(lat, lon, s.ToString("dddd, dd MMMM yyyy HH:mm:ss"), alerttype, reported, status, details, "QLD");
            }
            result = JsonConvert.SerializeObject(table);
            return result;
        }

        //get fire information from NSW Fire RSS feed and capture relevent information and pass it to front end
        [WebMethod]
        public static string getFiresNSW()
        {
            XmlDocument doc = new XmlDocument();

            doc.Load("https://www.rfs.nsw.gov.au/feeds/majorIncidents.xml");
            XmlNodeList nlist = doc.ChildNodes;

            XmlNodeList elemList = doc.GetElementsByTagName("item");
            String result = "";
            ArrayList arr = new ArrayList();
            DataTable table = new DataTable();
            table.Columns.Add("lat", typeof(string));
            table.Columns.Add("lon", typeof(string));
            table.Columns.Add("date", typeof(string));

            table.Columns.Add("alerttype", typeof(string));
            table.Columns.Add("location", typeof(string));
            table.Columns.Add("council", typeof(string));
            table.Columns.Add("status", typeof(string));
            table.Columns.Add("responsibleAgency", typeof(string));
            table.Columns.Add("state", typeof(string));

            foreach (XmlNode xn in elemList)
            {
                try
                {
                    XmlDocument content = new XmlDocument();

                    XmlNode n = xn.LastChild;

                    XmlNodeList tlist = xn.ChildNodes;

                    String lat = n.InnerText.Split(' ')[0];
                    String lon = n.InnerText.Split(' ')[1];
                    String date1 = tlist[5].InnerText.Substring(0, 10);
                    String desc = tlist[2].InnerText;

                    DateTime s = Convert.ToDateTime(tlist[4].InnerText.ToString());
                    string[] lines = Regex.Split(desc, "<br />");

                    String alerttype = lines[0].Split(':')[1];
                    String location = lines[1].Split(':')[1];
                    String council = lines[2].Split(':')[1];
                    String status = lines[3].Split(':')[1];
                    String responsibleAgency = lines[7].Split(':')[1];

                    table.Rows.Add(lat, lon, s.ToString("dddd, dd MMMM yyyy HH:mm:ss"), alerttype, location, council, status, responsibleAgency, "NSW");
                }
                catch (Exception ex) { }
            }
            result = JsonConvert.SerializeObject(table);
            return result;
        }

        private void refresh()
        {
            Response.Redirect("~/Z1111.aspx", false);
        }
    }
}