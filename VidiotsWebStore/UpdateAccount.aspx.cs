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
    public partial class UpdateAccount : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsTemplate)this.Master;
            if (!IsPostBack)
            {

            }

            string customerID = Request.QueryString["customerID"].ToString();
            if (!string.IsNullOrEmpty(customerID))
            {
                RetrieveAccount(customerID);
            }
        }

        protected void RetrieveAccount(string customerID)
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);
            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spGetCustomerDetails", conn);
                    SqlParameter param = new SqlParameter("@CustomerID", int.Parse(customerID));
                    cmd.Parameters.Add(param);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    conn.Open();
                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                    if (dr.HasRows)
                    {
                        dr.Read();
                        txtAddress.Text = dr["Street"].ToString();
                        txtCity.Text = dr["City"].ToString();
                        txtCountry.Text = dr["Country"].ToString();
                        txtDOB.Text = dr["DateOfBirth"].ToString();
                        txtEmail.Text = dr["Email"].ToString();
                        txtFirstName.Text = dr["FirstName"].ToString();
                        txtLastName.Text = dr["LastName"].ToString();
                        if(dr["MiddleInitial"].ToString() == null)
                        {
                            txtMiddleInitial.Text = "";
                        }
                        else
                        {
                            txtMiddleInitial.Text = dr["MiddleInitial"].ToString();
                        }
                        txtPassword.Text = dr["UserPassword"].ToString();
                        txtPhoneNumber.Text = dr["PhoneNumber"].ToString();
                        txtPostalCode.Text = dr["PostalCode"].ToString();
                        txtProvince.Text = dr["Province"].ToString();
                        txtUserName.Text = dr["UserName"].ToString();
                    }
                    
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            finally
            {
                dr.Close();
            }
        }
    }
}