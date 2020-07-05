using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
            Response.Redirect("Home.aspx");
    }
    protected void DataListFullPG_PreRender(object sender, EventArgs e)
    {
       
            Label lblExp = (Label)DataListFullPG.Items[0].FindControl("lblExp");
            String exp = lblExp.Text;

            if (exp == "01-01-1900")
                lblExp.Text = "Unapproved";


            Label pid;
            String pgid = "";

            /*Retrieving PG ID - used for where condition in db retrieval */
            pid = (Label)DataListFullPG.Items[0].FindControl("lblID");
            pgid = pid.Text;

            /*Retrieving Owner name*/
            DataListItem dli = DataListFullPG.Items[0] as DataListItem;
            Label lblOwnerID = dli.FindControl("lblOwner") as Label;
            Label lblID = dli.FindControl("lblID") as Label;

            String ownerName = "";
            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);
            String getOwner = "SELECT Name FROM Users where ID = (select @ownerid from PG where ID = @original_ID) ";
            SqlCommand cmd1 = new SqlCommand(getOwner, con);
            cmd1.Parameters.AddWithValue("ownerid", lblOwnerID.Text);
            cmd1.Parameters.AddWithValue("original_ID", lblID.Text);
            con.Open();
            SqlDataReader reader1 = cmd1.ExecuteReader();
            while (reader1.Read())
            {
                ownerName = reader1[0].ToString();
            }
            con.Close();

            Label lblOwnerName = dli.FindControl("lblOwnerName") as Label;
            lblOwnerName.Text = ownerName;

            /*Displaying available & unavailable amenities*/
            Dictionary<string, string> dictAmenities = new Dictionary<string, string>();

            String getAmenities = "select Electricity, AC, TV, WiFi, Laundry, Geyser, Refrigerator, CookingStove," +
            " StudyTable, Balcony, Parking, Security, Meals, NonVeg from PG where ID = @pid;";
            SqlCommand cmd = new SqlCommand(getAmenities, con);
            cmd.Parameters.AddWithValue("pid", pgid);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                dictAmenities.Add("Electricity", reader[0].ToString());
                dictAmenities.Add("AC", reader[1].ToString());
                dictAmenities.Add("Television", reader[2].ToString());
                dictAmenities.Add("WiFi", reader[3].ToString());
                dictAmenities.Add("Laundry", reader[4].ToString());
                dictAmenities.Add("Geyser", reader[5].ToString());
                dictAmenities.Add("Fridge", reader[6].ToString());
                dictAmenities.Add("Cooking Stove", reader[7].ToString());
                dictAmenities.Add("Study Table", reader[8].ToString());
                dictAmenities.Add("Balcony", reader[9].ToString());
                dictAmenities.Add("Parking", reader[10].ToString());
                dictAmenities.Add("Security", reader[11].ToString());
                dictAmenities.Add("Meals", reader[12].ToString());
                dictAmenities.Add("Non-Veg", reader[13].ToString());
            }
            con.Close();

            Label lblAvailable = (Label)DataListFullPG.Items[0].FindControl("lblAvailableAmn");
            Label lblUnavailable = (Label)DataListFullPG.Items[0].FindControl("lblUnavailableAmn");
            lblAvailable.Text = lblUnavailable.Text = "";

            foreach (KeyValuePair<string, string> amn in dictAmenities)
            {
                if (amn.Value == "Yes" || amn.Value == "Provided" || amn.Value == "Allowed")
                {
                    lblAvailable.Text += "<strong>" + amn.Key + ": </strong>" + amn.Value + "<br>";
                }
                if (amn.Value == "No" || amn.Value == "Not Provided" || amn.Value == "Not Allowed")
                {
                    lblUnavailable.Text += "<strong>" + amn.Key + ": </strong>" + amn.Value + "<br>";
                }
            }
       
    }
    protected void deletePG_Click(object sender, EventArgs e)
    {
       
            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);
            String delPG = "delete from PG where ID = @id";
            SqlCommand cmd = new SqlCommand(delPG, con);
            cmd.Parameters.AddWithValue("id", Request.QueryString["id"]);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            DataListFullPG.Visible = false;
            deletePG.Visible = false;
            lblEmpty.Text = "PG Removed Successfully";
            lblEmpty.ForeColor = System.Drawing.Color.Red;
            lblEmpty.Visible = true;
            linkBack.Visible = true;
            linkAll.Visible = true;
       
    }
}