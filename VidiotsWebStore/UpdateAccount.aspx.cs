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
                string customerID = "1";
                if (!string.IsNullOrEmpty(customerID))
                {
                    RetrieveAccount(customerID);
                }
            }

            //string customerID = Request.QueryString["customerID"].ToString();

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
                        txtEmail.Text = dr["EmailAddress"].ToString();
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if(ValidateAge() == true)
            {
                UpdateCustomer();
                master.masterMessage = "";
            }
            else
            {
                master.masterMessage = "Date of Birth is invalid. Must be 19 or older.";
            }
        }

        private bool ValidateAge()
        {
            string yearStr = txtDOB.Text.Substring(0, 4);
            int year = int.Parse(yearStr);
            if(year > DateTime.Now.Year - 19)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        private void UpdateCustomer()
        {
            //string customerID = Request.QueryString["customerID"].ToString();
            //int custID = int.Parse(customerID);
            int custID = 1;
            SqlCommand cmd = default(SqlCommand);
            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spUpdateCustomer", conn);
                    cmd.Parameters.AddWithValue("@CustomerID", custID);
                    cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
                    if(txtMiddleInitial.Text != string.Empty)
                    {
                        cmd.Parameters.AddWithValue("@MiddleInitial", txtMiddleInitial.Text);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@MiddleInitial", null);
                    }
                    cmd.Parameters.AddWithValue("@LastName", txtLastName.Text);
                    cmd.Parameters.AddWithValue("@UserName", txtUserName.Text);
                    cmd.Parameters.AddWithValue("@UserPassword", txtPassword.Text);
                    cmd.Parameters.AddWithValue("@DateOfBirth", txtDOB.Text);
                    cmd.Parameters.AddWithValue("@PhoneNumber", txtPhoneNumber.Text);
                    cmd.Parameters.AddWithValue("@EmailAddress", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@Street", txtAddress.Text);
                    cmd.Parameters.AddWithValue("@City", txtCity.Text);
                    cmd.Parameters.AddWithValue("@Province", txtProvince.Text);
                    cmd.Parameters.AddWithValue("@Country", txtCountry.Text);
                    cmd.Parameters.AddWithValue("@PostalCode", txtPostalCode.Text);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            finally
            {
                master.masterMessage = "Account Updated";
            }
        }
    }
}