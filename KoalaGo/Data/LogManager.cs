using System;
using System.IO;
using System.Web;

namespace KoalaGo.Data
{
    public static class LogManager
    {
        public static void writeToLog(String msg)
        {
            string fullPath = HttpContext.Current.Server.MapPath("assets/Log.txt");

            using (StreamWriter sw = File.AppendText(fullPath))
            {

                sw.WriteLine("timestamp:" + DateTime.Now.ToString() + "\t" + msg);

            }
        }
    }
}