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
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void DataList1_PreRender(object sender, EventArgs e)
    {
        
            for (int i = 0; i < DataList1.Items.Count; i++)
            {
                AjaxControlToolkit.CalendarExtender calendar = DataList1.Items[i].FindControl("CalendarExtender1") as AjaxControlToolkit.CalendarExtender;
                calendar.StartDate = DateTime.Today.AddDays(1);
                calendar.EndDate = DateTime.Today.AddMonths(3);
            }

            String year = DateTime.Today.Year.ToString();
            String month = DateTime.Today.Month.ToString();
            String day = DateTime.Today.Day.ToString();
            String fulldate = year + "-" + month + "-" + day;

            SqlDataSource1.SelectParameters["today"].DefaultValue = fulldate;

            if (DataList1.Items.Count == 0)
            {
                DataList1.Visible = false;
                pendingDL.Style.Add("display", "block");
            }
       
    }
    protected void DataList2_PreRender(object sender, EventArgs e)
    {
       
            if (DataList2.Items.Count == 0)
            {
                DataList2.Visible = false;
                confirmedDL.Style.Add("display", "block");
            }
        
    }
    protected void DataList3_PreRender(object sender, EventArgs e)
    {
        
            String year = DateTime.Today.Year.ToString();
            String month = DateTime.Today.Month.ToString();
            String day = DateTime.Today.Day.ToString();
            String fulldate = year + "-" + month + "-" + day;

            SqlDataSourcePast.SelectParameters["today"].DefaultValue = fulldate;

            if (DataList3.Items.Count == 0)
            {
                DataList3.Visible = false;
                pastDL.Style.Add("display", "block");
            }
        
    }
    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        
            int index = e.Item.ItemIndex;
            Label pid = (Label)DataList1.Items[index].FindControl("lblPGID");
            Label pgname = (Label)DataList1.Items[index].FindControl("lblName");
            Label pgaddr = (Label)DataList1.Items[index].FindControl("lblAddr");
            Label sid = (Label)DataList1.Items[index].FindControl("lblSeekID");
            TextBox dt = (TextBox)DataList1.Items[index].FindControl("txtDate");
            Button conf = (Button)DataList1.Items[index].FindControl("btnConfirm");
            Button del = (Button)DataList1.Items[index].FindControl("btnDelete");
            RequiredFieldValidator req1 = (RequiredFieldValidator)DataList1.Items[index].FindControl("RequiredFieldValidator1");
            RegularExpressionValidator reg1 = (RegularExpressionValidator)DataList1.Items[index].FindControl("RegularExpressionValidator1");

            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);

            //Get real seeker email
            /*String sEmail = "";

            String getSeekerEmail = "select Email from Users where ID = @sid";
            SqlCommand cmd2 = new SqlCommand(getSeekerEmail, con);
            cmd2.Parameters.AddWithValue("sid", sid.Text);

            SqlDataReader reader2 = cmd2.ExecuteReader();
            while (reader2.Read())
            {
                sEmail = reader2[0].ToString();
            }
            */

            if (e.CommandName == "confirmVisit")
            {

                req1.ControlToValidate = "txtDate";
                reg1.ControlToValidate = "txtDate";

                req1.Visible = true;
                reg1.Visible = true;

                String o_name = "", o_mobile = "";
                
                    DateTime visit = DateTime.Parse(dt.Text);
                    String visitDt = visit.Year + "-" + visit.Month + "-" + visit.Day;


                    String setDt = "update SiteVisits set VisitDate = @dt where PID = @pid and SID = @sid";
                    SqlCommand cmd = new SqlCommand(setDt, con);
                    cmd.Parameters.AddWithValue("dt", visitDt);
                    cmd.Parameters.AddWithValue("pid", pid.Text);
                    cmd.Parameters.AddWithValue("sid", sid.Text);

                    String getOwnerDetails = "select Name, Mobile from Users where ID = @id";
                    SqlCommand cmd1 = new SqlCommand(getOwnerDetails, con);
                    cmd1.Parameters.AddWithValue("id", Session["ownerid"].ToString());


                    con.Open();

                    int i = cmd.ExecuteNonQuery();

                    SqlDataReader reader = cmd1.ExecuteReader();
                    while (reader.Read())
                    {
                        o_name = reader[0].ToString();
                        o_mobile = reader[1].ToString();
                    }



                    con.Close();


                    //SendEmailApproval(sEmail, pgname.Text, pgaddr.Text, o_name, o_mobile, dt.Text);
                    SendEmailApproval(pgname.Text, pgaddr.Text, o_name, o_mobile, dt.Text);
               
                Response.Redirect(Request.RawUrl);


            }
            else if (e.CommandName == "deleteReq")
            {
                String delPG = "delete from SiteVisits where PID = @pid and SID = @sid";
                SqlCommand cmd = new SqlCommand(delPG, con);
                cmd.Parameters.AddWithValue("pid", pid.Text);
                cmd.Parameters.AddWithValue("sid", sid.Text);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                DataList1.DataBind();

                //SendEmailDisapproval(sEmail, pgname.Text);
                SendEmailDisapproval(pgname.Text);
            }
       
    }

    //public void SendEmailApproval(string seekerMail, string pgName, string address, string owner, string contact, string vdate)
    public void SendEmailApproval(string pgName, string address, string owner, string contact, string vdate)
    {
        
            //MailMessage mailmsg = new MailMessage("pds1468@gmail.com", seekerMail); 
            MailMessage mailmsg = new MailMessage("pds1468@gmail.com", "poorvadsurve@gmail.com");
            mailmsg.Subject = "StayHub.com: Visit request approved!";
            String emailBody = "Greetings from StayHub.com! \n\n" +
            "Your visit request for the PG " + pgName + " placed on " + DateTime.Now.ToString() + " has been approved by the owner. \nThe details are as follows:" +
            "\n\nPG Name: " + pgName +
            "\n\nAddress: " + address +
            "\n\nOwner: " + owner +
            "\n\nContact: " + contact +
            "\n\nVisit Date: " + vdate +
            "\n\nYou may contact the owner regarding the same. " +
            "You can view these details anytime in the 'PG Visits' section on our website." +
            "\n\nThanking You, \nStayHub Team";

            mailmsg.Body = emailBody;
            SmtpClient smtpclient = new SmtpClient("smtp.gmail.com", 587);
            smtpclient.Credentials = new System.Net.NetworkCredential() { UserName = "pds1468@gmail.com", Password = "kiteskites" };
            smtpclient.EnableSsl = true;
            smtpclient.Send(mailmsg);
       
    }
    //public void SendEmailDisapproval(string seekerMail, string pgName)
    public void SendEmailDisapproval(string pgName)
    {
       
            //MailMessage mailmsg = new MailMessage("pds1468@gmail.com", seekerMail);
            MailMessage mailmsg = new MailMessage("pds1468@gmail.com", "poorvadsurve@gmail.com");
            mailmsg.Subject = "StayHub.com: Visit request disapproved";
            String emailBody = "Greetings from StayHub.com! \n\n" +
            "We regret to inform you that your visit request for the PG " + pgName + " placed on " + DateTime.Now.ToString() + " has been disapproved by the owner. " +
            "\n\nYou can try placing the request again some other time or explore various other PGs in our catalog." +
            "\nYou can easily add any PG to your interests for future reference while you do so. " +
            "\nAll PGs in your interest will be listed under the 'My Interests' section on our website. " +
            "\n\nThanking You, \nStayHub Team";

            mailmsg.Body = emailBody;
            SmtpClient smtpclient = new SmtpClient("smtp.gmail.com", 587);
            smtpclient.Credentials = new System.Net.NetworkCredential() { UserName = "pds1468@gmail.com", Password = "kiteskites" };
            smtpclient.EnableSsl = true;
            smtpclient.Send(mailmsg);
        
    }

}