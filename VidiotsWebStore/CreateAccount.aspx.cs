using System;
using System.Collections.Generic;
using System.Linq;
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

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            InsertAccount();
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
                    cmd.Parameters.AddWithValue("@DateOfBirth", dateOfBirth);
                    cmd.Parameters.AddWithValue("@Street", street);
                    cmd.Parameters.AddWithValue("@City", city);
                    cmd.Parameters.AddWithValue("@PostalCode", postalCode);
                    cmd.Parameters.AddWithValue("@Province", province);
                    cmd.Parameters.AddWithValue("@Country", country);
                    cmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
                    cmd.Parameters.AddWithValue("@EmailAddress", email);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch(Exception ex)
            {

            }
        }
    }
}