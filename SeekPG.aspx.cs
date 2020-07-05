using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;

public partial class _Default : System.Web.UI.Page
{
    int f = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

        String city = Request.QueryString["city"].ToString();
        Label lblCity = lblCurrCity;
        lblCity.Text = city;
        Label pid;
        String pgid = "";

        if (DataListFullPG.Items.Count != 0)
        {
            int c = DataListFullPG.Items.Count;
            for (int i = 0; i < c; i++)
            {
                /*Used for displaying login tooltip */
                Button intr = (Button)DataListFullPG.Items[i].FindControl("btnInterest1");
                Button req = (Button)DataListFullPG.Items[i].FindControl("btnVisit");

                /*Used for displaying image expand tooltip*/
                ImageButton i1 = (ImageButton)DataListFullPG.Items[i].FindControl("ImageButton1");
                ImageButton i2 = (ImageButton)DataListFullPG.Items[i].FindControl("ImageButton2");
                ImageButton i3 = (ImageButton)DataListFullPG.Items[i].FindControl("ImageButton3");
                ImageButton i4 = (ImageButton)DataListFullPG.Items[i].FindControl("ImageButton4");
                ImageButton i5 = (ImageButton)DataListFullPG.Items[i].FindControl("ImageButton5");

                intr.ToolTip = req.ToolTip = "You need to log in first!";
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
        else if (e.CommandName == "addInterest")
        {

            int index = e.Item.ItemIndex;
            Label pid = (Label)DataListFullPG.Items[index].FindControl("lblID");
            Button int1 = (Button)DataListFullPG.Items[index].FindControl("btnInterest1");
            Button int2 = (Button)DataListFullPG.Items[index].FindControl("btnInterest2");

            Label init = (Label)DataListFullPG.Items[index].FindControl("lblInterests");
            int interests = Int32.Parse(init.Text);

            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);

            if (Session["userid"] != null)
            {
                String addIntr = "insert into Interests(UID, PID) values (@uid, @pid);";
                SqlCommand cmd = new SqlCommand(addIntr, con);
                cmd.Parameters.AddWithValue("uid", Session["userid"].ToString());
                cmd.Parameters.AddWithValue("pid", pid.Text);

                String incnum = "update PG set Interests = @interests where ID = @pid;";
                SqlCommand cmd2 = new SqlCommand(incnum, con);
                cmd2.Parameters.AddWithValue("interests", interests + 1);
                cmd2.Parameters.AddWithValue("pid", pid.Text);

                con.Open();
                int i = cmd.ExecuteNonQuery();
                cmd2.ExecuteNonQuery();

                con.Close();
                if (i > 0)
                {
                    int1.Visible = false;
                    int2.Visible = true;
                }
                else
                {
                    int1.Visible = true;
                    int2.Visible = false;
                }
                DataListFullPG.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alertMessage();", true);
                int1.ToolTip = "You need to login first!";
            }
        }
        else if (e.CommandName == "remInterest")
        {
            int index = e.Item.ItemIndex;
            Label pid = (Label)DataListFullPG.Items[index].FindControl("lblID");
            Button int1 = (Button)DataListFullPG.Items[index].FindControl("btnInterest1");
            Button int2 = (Button)DataListFullPG.Items[index].FindControl("btnInterest2");

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
            if (i > 0)
            {
                int1.Visible = true;
                int2.Visible = false;
            }
            else
            {
                int1.Visible = false;
                int2.Visible = true;
            }
            DataListFullPG.DataBind();
        }
        else if (e.CommandName == "reqVisit")
        {
            int index = e.Item.ItemIndex;
            String pid = e.CommandArgument.ToString();
            //Label pid = (Label)DataListFullPG.Items[index].FindControl("lblID");
            Button req = (Button)DataListFullPG.Items[index].FindControl("btnVisit");
            Label oid = (Label)DataListFullPG.Items[index].FindControl("lblOID");
            Label pgname = (Label)DataListFullPG.Items[index].FindControl("lblName");
            Label pgaddr = (Label)DataListFullPG.Items[index].FindControl("lblAddr");
            Label pgowner = (Label)DataListFullPG.Items[index].FindControl("lblOwner");
            Label pgcontact = (Label)DataListFullPG.Items[index].FindControl("lblContact");

            if (req.Text == "Request A Visit")
            {
                String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
                SqlConnection con = new SqlConnection(myConn);

                if (Session["userid"] != null)
                {
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
                        DataListFullPG.DataBind();

                        SendEmail(pgname.Text, pgaddr.Text, pgowner.Text, pgcontact.Text);
                    }
                    else
                    {
                        req.Text = "Request A Visit";
                        req.Enabled = true;
                    }



                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alertMessage();", true);
                    req.ToolTip = "You need to login first!";
                }

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


    public void SendEmail(string pgName, string address, string owner, string contact)
    {

        //String seekerEmail = Session["user"].ToString();
        //MailMessage mailmsg = new MailMessage("pds1468@gmail.com", seekerEmail);

        MailMessage mailmsg = new MailMessage("pds1468@gmail.com", "poorvadsurve@gmail.com");
        mailmsg.Subject = "StayHub.com: Visit request sent";
        String emailBody = "Greetings from StayHub.com! \n\n" +
        "You have sent a visit request for the PG " + pgName + " on " + DateTime.Now.ToString() + "\nThe details are as follows:" +
        "\n\nPG Name: " + pgName +
        "\n\nAddress: " + address +
        "\n\nOwner: " + owner +
        "\n\nContact: " + contact +
        "\n\nYou will be notified about the visit date once the owner approves your request. " +
        "Meanwhile if you wish to cancel this visit before approval, you can do so from the 'PG Visits' section on our website." +
        "\n\nThanking You, \nStayHub Team";

        mailmsg.Body = emailBody;
        SmtpClient smtpclient = new SmtpClient("smtp.gmail.com", 587);
        smtpclient.Credentials = new System.Net.NetworkCredential() { UserName = "pds1468@gmail.com", Password = "kiteskites" };
        smtpclient.EnableSsl = true;
        smtpclient.Send(mailmsg);

    }

    protected void DataListFullPG_PreRender(object sender, EventArgs e)
    {

        int c = DataListFullPG.Items.Count;
        if (c == 0)
        {
            emptyStatus.Style.Add("display", "inline");
            lblDefault.Text = "No PGs available";
            ddlSorting.Visible = false;
            btnSelectFilters.Visible = false;

            if (IsPostBack)
            {
                ddlSorting.Visible = true;
                btnSelectFilters.Visible = true;
                lblOtherC.Visible = false;
            }
        }
        else
        {
            emptyStatus.Style.Add("display", "none");
        }
        if (Session["userid"] == null)
        {
            for (int i = 0; i < c; i++)
            {
                Label ownerName = (Label)DataListFullPG.Controls[i].FindControl("lblOwner");
                Label ownerMob = (Label)DataListFullPG.Controls[i].FindControl("lblContact");
                Label ownerEmail = (Label)DataListFullPG.Controls[i].FindControl("lblEmail");
                Label sep = (Label)DataListFullPG.Controls[i].FindControl("lblSep");
                ownerName.Visible = false;
                ownerMob.Visible = false;
                ownerEmail.Visible = false;
                sep.Text = "Login to view owner's contact details";

            }

        }
        if (Session["userid"] != null)
        {
            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);


            for (int i = 0; i < c; i++)
            {
                Label pid = (Label)DataListFullPG.Items[i].FindControl("lblID");

                /*Interest Button*/
                Button int1 = (Button)DataListFullPG.Items[i].FindControl("btnInterest1");
                Button int2 = (Button)DataListFullPG.Items[i].FindControl("btnInterest2");

                String getIntr = "select * from Interests where UID = @uid and PID = @pid;";
                SqlCommand cmd = new SqlCommand(getIntr, con);
                cmd.Parameters.AddWithValue("uid", Session["userid"].ToString());
                cmd.Parameters.AddWithValue("pid", pid.Text);

                /*Site Visit Button*/
                Button req = (Button)DataListFullPG.Items[i].FindControl("btnVisit");
                String query = "select * from SiteVisits where SID = @sid and PID = @pid;";
                SqlCommand cmd2 = new SqlCommand(query, con);
                cmd2.Parameters.AddWithValue("sid", Session["userid"].ToString());
                cmd2.Parameters.AddWithValue("pid", pid.Text);


                /*Execute query for Interest*/
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    int1.Visible = false;
                    int2.Visible = true;
                }
                else
                {
                    int1.Visible = true;
                    int2.Visible = false;
                }
                con.Close();

                /*Execute query for SiteVisit*/
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
    protected void ddlSorting_SelectedIndexChanged(object sender, EventArgs e)
    {
        filtering();
        sorting();
    }

    protected void btnApplyFilters_Click(object sender, EventArgs e)
    {
        filtering();
        sorting();
    }

    public string[] selectedFiltersOfCheckBoxList(CheckBoxList chkList)
    {
        List<string> selectedFilters = new List<string>();

        foreach (ListItem item in chkList.Items)
        {
            if (item.Selected)
            {
                selectedFilters.Add(item.Value);
            }
        }
        return selectedFilters.ToArray();
    }



    protected void sorting()
    {

        String sortParam = ddlSorting.SelectedValue;

        String sortQuery = "";
        if (sortParam == "highInterests")
            sortQuery = " order by PG.Interests desc, PG.Name asc";
        else if (sortParam == "lowBudget")
            sortQuery = " order by PG.Rent, PG.Name asc";
        else if (sortParam == "highBudget")
            sortQuery = " order by PG.Rent desc, PG.Name asc";
        else if (sortParam == "newest")
            sortQuery = " order by PG.DateAdded desc, PG.Name asc";
        else if (sortParam == "oldest")
            sortQuery = " order by PG.DateAdded, PG.Name asc";

        SqlDataSourceFullPG.SelectCommand += sortQuery;

    }


    protected void filtering()
    {

        String filterQuery = "";
        String[] filterValues = selectedFiltersOfCheckBoxList(chkFilters);
        int c = filterValues.Length;
        lblFilterCount.Text = c.ToString();


        if (filterValues.Contains("Boys") && filterValues.Contains("Girls") && filterValues.Contains("Couples"))
        {   //boys/girls/couples
            filterQuery += " and (PG.Occupancy like '%Boys%' or PG.Occupancy like '%Girls%' or PG.Occupancy like '%Couples%') ";
        }
        else if (filterValues.Contains("Boys") && !filterValues.Contains("Girls") && !filterValues.Contains("Couples"))
        {   //only boys
            filterQuery += " and PG.Occupancy like '%Boys%' ";
        }
        else if (filterValues.Contains("Girls") && !filterValues.Contains("Boys") && !filterValues.Contains("Couples"))
        {   //only girls
            filterQuery += " and PG.Occupancy like '%Girls%' ";
        }
        else if (filterValues.Contains("Couples") && !filterValues.Contains("Boys") && !filterValues.Contains("Girls"))
        {   //only couples
            filterQuery += " and PG.Occupancy like '%Married Couples%' ";
        }
        else if (filterValues.Contains("Boys") && filterValues.Contains("Girls"))
        {   //boys/girls
            filterQuery += " and (PG.Occupancy like '%Boys%' or PG.Occupancy like '%Girls%') ";
        }
        else if (filterValues.Contains("Boys") && filterValues.Contains("Couples"))
        {   //boys/couples
            filterQuery += " and (PG.Occupancy like '%Boys%' or PG.Occupancy like '%Couples%') ";
        }
        else if (filterValues.Contains("Girls") && filterValues.Contains("Couples"))
        {   //girls/couples
            filterQuery += " and (PG.Occupancy like '%Girls%' or PG.Occupancy like '%Couples%') ";
        }
        if (filterValues.Contains("NonVeg"))
        {
            filterQuery += " and PG.NonVeg ='Allowed' ";
        }
        if (filterValues.Contains("Meals"))
        {
            filterQuery += " and PG.Meals = 'Provided' ";
        }

        if (filterValues.Length == 0)
        {
            filterQuery += " ";
        }

        SqlDataSourceFullPG.SelectCommand += filterQuery;

    }
}