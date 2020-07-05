using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Site2 : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] != null)
        {
            //lblUser.Text = "Hello, " + Session["user"].ToString() + " !";
            //linkAccount.Visible = true;
            btnLog.Text = "Logout";
        }
        else
        {
            //lblUser.Text = "Hello, Guest!";
            //linkAccount.Visible = false;
            btnLog.Text = "Login";
        }
    }
    protected void btnLog_Click(object sender, EventArgs e)
    {
        if (btnLog.Text == "Logout")
        {
            Session.RemoveAll();
            Session.Abandon();
            Response.Redirect("Home.aspx");
        }
        else
        {
            btnLog.Text = "Login";
            Response.Redirect("Login.aspx");
        }
    }
}
