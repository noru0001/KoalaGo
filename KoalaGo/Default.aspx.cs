using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KoalaGo
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btn1_Click(object sender, EventArgs e)
        {
            if (txtcode.Text.Trim().ToUpper().Equals("KOALA1"))
            {
                Response.Redirect("~/index.aspx", false);
            }
            else
            {
                lblmsg.Text = "Invalid code";
            }
        }
    }
}