using KoalaGo.Data;
using Newtonsoft.Json;
using System;
using System.Data;
using System.Web.Services;


namespace KoalaGo
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string getKoalaInfo()
        {
            DataManager dm = new DataManager();
            DataTable dt = dm.getKoalaHabitat_basedon_datefound();

            string result = JsonConvert.SerializeObject(dt);




            return result;
        }
    }
}