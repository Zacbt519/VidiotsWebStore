using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VidiotsWebStore
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsTemplate)this.Master;
            
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Login(txtUserName.Text, txtPassword.Text);
            Response.Redirect("~/index.aspx");
            
        }

        private void LoginToCheckout()
        {
            if (string.IsNullOrEmpty(txtUserName.Text) || string.IsNullOrEmpty(txtPassword.Text))
            {
                master.masterMessage = "Username and/or Password cannot be empty!";
            }
            else
            {
                Login(txtUserName.Text, txtPassword.Text);
            }
        }

        private void Login(string username, string password)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    SqlCommand cmd = new SqlCommand("spAdminLogin", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@AdminUsername", username));
                    cmd.Parameters.Add(new SqlParameter("@AdminPassword", password));
                    SqlParameter userID = new SqlParameter("@AdminID", System.Data.SqlDbType.SmallInt);
                    SqlParameter userType = new SqlParameter("@UserType", System.Data.SqlDbType.Char, 9);
                    userID.Direction = System.Data.ParameterDirection.Output;
                    userType.Direction = System.Data.ParameterDirection.Output;
                    cmd.Parameters.Add(userID);
                    cmd.Parameters.Add(userType);

                    cmd.Connection.Open();

                    cmd.ExecuteNonQuery();

                    Session["UserType"] = userType.Value.ToString().Replace(" ", "");
                    Session["AdminID"] = userID.Value.ToString().Replace(" ", "");

                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }

        }
    }
}