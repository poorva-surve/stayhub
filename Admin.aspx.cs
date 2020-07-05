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
        if (Session["admin"] != null)
        {
            lblUser.Text = "Hello, " + Session["admin"].ToString() + "!";
        }
        else
            Response.Redirect("Home.aspx");
    }
}