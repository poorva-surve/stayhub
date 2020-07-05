using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["owner"] != null)
        {
            lblUser.Text = "Hello, " + Session["owner"].ToString() + "!";
        }
        else
            Response.Redirect("Home.aspx");
    }
}