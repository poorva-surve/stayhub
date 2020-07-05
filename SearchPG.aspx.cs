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

    }

    protected void DataListCities_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "cityName")
        {
            Response.Redirect("SeekPG.aspx?city="+e.CommandArgument.ToString());
        }
    }
}