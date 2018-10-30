using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace VidiotsWebStore
{
    public partial class CreateAccount : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsTemplate)this.Master;
            if (!IsPostBack)
            {
                PopulateCountries();
            }
        }

        private void PopulateCountries()
        {
            ddlCountry.Items.Add("Canada");
            ddlCountry.Items.Add("USA");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ValidateAge() == true)
            {
                master.masterMessage = "";
                InsertAccount();
                
            }
            else
            {
                master.masterMessage = "Date of Birth is invalid. Must be 19 or older.";
            }
        }

        private void InsertAccount()
        {
            string firstName = txtFirstName.Text;
            string middleInitial = "";
            if (txtMiddleInitial.Text == string.Empty)
            {
                middleInitial = "";
            }
            else
            {
                middleInitial = txtMiddleInitial.Text;
            }
            string lastName = txtLastName.Text;
            string userName = txtUserName.Text;
            string userPassword = txtPassword.Text;
            string dateOfBirth = txtDOB.Text;
            string street = txtAddress.Text;
            string city = txtCity.Text;
            string postalCode = txtPostalCode.Text;
            string province = ddlProvince.SelectedItem.ToString();
            string country = ddlCountry.SelectedItem.ToString();
            string phoneNumber = txtPhoneNumber.Text;
            string email = txtEmail.Text;

            SqlCommand cmd = default(SqlCommand);
            try
            {
                using(SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spCreateAccount", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@MiddleInitial", middleInitial);
                    cmd.Parameters.AddWithValue("@LastName", lastName);
                    cmd.Parameters.AddWithValue("@UserName", userName);
                    cmd.Parameters.AddWithValue("@UserPassword", userPassword);
                    cmd.Parameters.AddWithValue("@DateOfBirth", Convert.ToDateTime(dateOfBirth));
                    cmd.Parameters.AddWithValue("@Street", street);
                    cmd.Parameters.AddWithValue("@City", city);
                    cmd.Parameters.AddWithValue("@PostalCode", postalCode);
                    cmd.Parameters.AddWithValue("@Province", province);
                    cmd.Parameters.AddWithValue("@Country", country);
                    cmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                    cmd.Parameters.AddWithValue("@EmailAddress", email);
                    SqlParameter output = new SqlParameter("@CustomerID", System.Data.SqlDbType.Int);
                    output.Direction = System.Data.ParameterDirection.Output;
                    cmd.Parameters.Add(output);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    SendConfirmationEmail(email, int.Parse(output.Value.ToString()));
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }

            finally
            {
                master.masterMessage = "Account Created!";   
            }
        } 

        private void SendConfirmationEmail(string email, int accountID)
        {
            try
            {
                string msg = "<p>Your Account has been created, Click the link to confirm your account <a href='http://localhost:49487/Confirmation.aspx?customerID=" + accountID + "'>Confirmation Link</a></p>";
                MailMessage mail = new MailMessage();
                mail.To.Add(email);
                mail.From = new MailAddress("noreply@vidiots.com");
                mail.Subject = "Account Confirmation";
                mail.IsBodyHtml = true;
                mail.Body = msg;

                SmtpClient smtpClient = new SmtpClient("localhost");
                smtpClient.Send(mail);
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
          
        }

        private bool ValidateAge()
        {
            string yearStr = txtDOB.Text.Substring(0, 4);
            int year = int.Parse(yearStr);
            if (year > DateTime.Now.Year - 19)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddlCountry.SelectedValue == "Canada")
            {
                string[] prov = {"AB", "BC", "MB", "NB", "NL", "NT", "NS", "NU", "ON", "PE", "QC", "SK", "YT" };
                ddlProvince.DataSource = prov;
                ddlProvince.DataBind();
                ddlProvince.Enabled = true;
                revZip.ValidationExpression = @"^([a-zA-Z]\d[a-zA-Z]( )?\d[a-zA-Z]\d)$";
            }
            else if(ddlCountry.SelectedValue == "USA")
            {
                string[] states = {"AL", "AK", "AS", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FM", "FL", "GA", "GU", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MH", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PW", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VI", "VA", "WA", "WV", "WI", "WY"};
                ddlProvince.DataSource = states;
                ddlProvince.DataBind();
                ddlProvince.Enabled = true;
                revZip.ValidationExpression = @"^\d{5}$";
            }
            else
            {
                ddlProvince.SelectedIndex = 0;
                ddlProvince.DataSource = null;
                ddlProvince.DataBind();
                ddlProvince.Items.Insert(0, "---Select a Province/State");
                ddlProvince.Enabled = false;
            }
        }
    }
}