using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ErrorPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string urlName = Request.UrlReferrer.ToString();
            HyperLink1.NavigateUrl = urlName;
        }
        catch (Exception exc)
        {
            HyperLink1.NavigateUrl = "~/Home.aspx";
        }
    }
}