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

        if (Session["userid"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        Label pid;
        String pgid = "";

        if (DataListFullPG.Items.Count != 0)
        {
            int c = DataListFullPG.Items.Count;
            for (int i = 0; i < c; i++)
            {

                /*Used for displaying image expand tooltip*/
                ImageButton i1 = (ImageButton)DataListFullPG.Items[i].FindControl("ImageButton1");
                ImageButton i2 = (ImageButton)DataListFullPG.Items[i].FindControl("ImageButton2");
                ImageButton i3 = (ImageButton)DataListFullPG.Items[i].FindControl("ImageButton3");
                ImageButton i4 = (ImageButton)DataListFullPG.Items[i].FindControl("ImageButton4");
                ImageButton i5 = (ImageButton)DataListFullPG.Items[i].FindControl("ImageButton5");

                i1.ToolTip = i2.ToolTip = i3.ToolTip = i4.ToolTip = i5.ToolTip = "Click to expand image";

                if (i1.ImageUrl == "")
                    i1.Visible = false;
                if (i2.ImageUrl == "")
                    i2.Visible = false;
                if (i3.ImageUrl == "")
                    i3.Visible = false;
                if (i4.ImageUrl == "")
                    i4.Visible = false;
                if (i5.ImageUrl == "")
                    i5.Visible = false;


                /*Retrieving PG ID - used for where condition in db retrieval */
                pid = (Label)DataListFullPG.Items[i].FindControl("lblID");
                pgid = pid.Text;

                /*Displaying available & unavailable amenities*/
                Dictionary<string, string> dictAmenities = new Dictionary<string, string>();
                String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
                SqlConnection con = new SqlConnection(myConn);
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

                Label lblAvailable = (Label)DataListFullPG.Items[i].FindControl("lblAvailableAmn");
                Label lblUnavailable = (Label)DataListFullPG.Items[i].FindControl("lblUnavailableAmn");
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
        }

    }

    protected void DataListFullPG_ItemCommand(object source, DataListCommandEventArgs e)
    {

        if (e.CommandName == "readMore")
        {
            int index = e.Item.ItemIndex;
            Table allDetails = (Table)DataListFullPG.Items[index].FindControl("infoTable");
            Button view = (Button)DataListFullPG.Items[index].FindControl("btnExpand");
            if (view.Text == "Read More...")
            {
                view.Text = "See Less...";
                allDetails.Visible = true;
            }
            else
            {
                view.Text = "Read More...";
                allDetails.Visible = false;
            }
        }

        else if (e.CommandName == "remInterest")
        {
            int index = e.Item.ItemIndex;
            Label pid = (Label)DataListFullPG.Items[index].FindControl("lblID");
            //Button intr = (Button)DataListFullPG.Items[index].FindControl("btnInterest");

            Label init = (Label)DataListFullPG.Items[index].FindControl("lblInterests");
            int interests = Int32.Parse(init.Text);

            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);

            String addIntr = "delete from Interests where UID = @uid and PID = @pid;";
            SqlCommand cmd = new SqlCommand(addIntr, con);
            cmd.Parameters.AddWithValue("uid", Session["userid"].ToString());
            cmd.Parameters.AddWithValue("pid", pid.Text);

            String decnum = "update PG set Interests = @interests where ID = @pid;";
            SqlCommand cmd2 = new SqlCommand(decnum, con);
            cmd2.Parameters.AddWithValue("interests", interests - 1);
            cmd2.Parameters.AddWithValue("pid", pid.Text);

            con.Open();
            int i = cmd.ExecuteNonQuery();
            cmd2.ExecuteNonQuery();

            con.Close();
            //if (i > 0)
            //{
            //    int1.Visible = true;
            //    int2.Visible = false;
            //}
            //else
            //{
            //    int1.Visible = false;
            //    int2.Visible = true;
            //}
            DataListFullPG.DataBind();
        }
        else if (e.CommandName == "reqVisit")
        {
            int index = e.Item.ItemIndex;
            String pid = e.CommandArgument.ToString();
            //Label pid = (Label)DataListFullPG.Items[index].FindControl("lblID");
            Button req = (Button)DataListFullPG.Items[index].FindControl("btnVisit");
            Label oid = (Label)DataListFullPG.Items[index].FindControl("lblOID");

            if (req.Text == "Request A Visit")
            {
                String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
                SqlConnection con = new SqlConnection(myConn);


                String query = "insert into SiteVisits(PID, SID, OID) values (@pid, @sid, @oid);";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("pid", pid);
                cmd.Parameters.AddWithValue("sid", Session["userid"].ToString());
                cmd.Parameters.AddWithValue("oid", oid.Text);


                con.Open();
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i > 0)
                {
                    req.Text = "Visit Requested!";
                    req.Enabled = false;
                }
                else
                {
                    req.Text = "Request A Visit";
                    req.Enabled = true;
                }
                DataListFullPG.DataBind();


            }
            else
            {
                req.Enabled = false;
            }

        }
        else if (e.CommandName == "pgImg")
        {
            String arg = e.CommandArgument.ToString();
            String a = arg.Substring(2);
            String script = "window.open('" + a + "')";
            ScriptManager.RegisterStartupScript(this, GetType(), "openImage", script, true);
        }
    }

    protected void DataListFullPG_PreRender(object sender, EventArgs e)
    {

        /*Site Visit Button*/
        String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
        SqlConnection con = new SqlConnection(myConn);


        int c = DataListFullPG.Items.Count;
        for (int i = 0; i < c; i++)
        {
            Label pid = (Label)DataListFullPG.Items[i].FindControl("lblID");
            Button req = (Button)DataListFullPG.Items[i].FindControl("btnVisit");
            String query = "select * from SiteVisits where SID = @sid and PID = @pid;";
            SqlCommand cmd2 = new SqlCommand(query, con);
            cmd2.Parameters.AddWithValue("sid", Session["userid"].ToString());
            cmd2.Parameters.AddWithValue("pid", pid.Text);

            con.Open();
            SqlDataReader reader2 = cmd2.ExecuteReader();
            if (reader2.HasRows)
            {
                req.Text = "Visit Requested!";
                req.Enabled = false;
            }
            con.Close();
        }

    }
}