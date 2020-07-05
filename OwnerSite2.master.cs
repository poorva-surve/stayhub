using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OwnerSite : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["owner"] != null)
        {
            //lblUser.Text = Session["owner"].ToString();
            //linkAccount.Visible = true;
            btnLog.Text = "Logout";
        }
        else
        {
            //lblUser.Text = "Guest";
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
