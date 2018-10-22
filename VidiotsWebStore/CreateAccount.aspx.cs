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
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ValidateAge() == true)
            {
                InsertAccount();
                master.masterMessage = "";
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
            string province = txtProvince.Text;
            string country = txtCountry.Text;
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
                string msg = "<p>Your Account has been created, Click the link to confirm your account <a href='Confirmation.aspx?customerID=" + accountID + "'>Confirmation Link</a></p>";
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
    }
}