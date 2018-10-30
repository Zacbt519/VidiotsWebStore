using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VidiotsWebStore
{
    public partial class Order : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsTemplate master;
        int billingID;
        protected void Page_Load(object sender, EventArgs e)
        {

            master = (VidiotsTemplate)this.Master;
            string customerID = Session["customerID"].ToString();
            if (!IsPostBack)
            {
                GetBillingAddress(customerID);
            }
        }

        private void GetBillingAddress(string customerID)
        {
            try
            {
                SqlDataReader dr = default(SqlDataReader);
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    SqlCommand cmd = new SqlCommand("spGetCustomerBillingAddress", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@CustomerID", int.Parse(customerID)));
                    conn.Open();
                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                    if (dr.HasRows)
                    {
                        dr.Read();
                        txtBillingStreet.Text = dr["Street"].ToString();
                        txtBillingCity.Text = dr["City"].ToString();
                        txtBillingCountry.Text = dr["Country"].ToString();
                        txtBillingProvince.Text = dr["Province"].ToString();
                        txtBillingPostal.Text = dr["PostalCode"].ToString();
                        billingID = int.Parse(dr["AddressID"].ToString());
                    }

                    
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            finally
            {
                
            }
        }

        protected void chkShipping_CheckedChanged(object sender, EventArgs e)
        {
            if(chkShipping.Checked == true)
            {
                pnlShipping.Visible = true;
            }
            else
            {
                pnlShipping.Visible = false;
                rfvCity.Enabled = false;
                rfvCountry.Enabled = false;
                rfvPostal.Enabled = false;
                rfvProvince.Enabled = false;
                rfvStreet.Enabled = false;
            }
        }

        protected void rdoPaypal_CheckedChanged(object sender, EventArgs e)
        {
            pnlCredit.Visible = false;
            rfvCardNum.Enabled = false;
            rfvCode.Enabled = false;
            rfvExpiration.Enabled = false;
        }

        protected void rdoCredit_CheckedChanged(object sender, EventArgs e)
        {
            pnlCredit.Visible = true;
            rfvCardNum.Enabled = true;
            rfvCode.Enabled = true;
            rfvExpiration.Enabled = true;
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                
                if (chkShipping.Checked == true)
                {
                    UpdateBillingAddress();
                    CreateOrder(CreateShippingAddress(), GenerateAuthNumber());
                    SendOrderEmail();
                }
                else
                {
                    UpdateBillingAddress();
                    CreateOrder(GenerateAuthNumber());
                    SendOrderEmail();
                }
                
            }
            catch(Exception ex)
            {
                master.masterMessage = ex.Message;
            }
        }

        private void UpdateBillingAddress()
        {
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                SqlCommand cmd = new SqlCommand("spUpdateBillingAddress", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@AddressID", billingID));
                cmd.Parameters.Add(new SqlParameter("@Street", txtBillingStreet.Text));
                cmd.Parameters.Add(new SqlParameter("@City", txtBillingCity.Text));
                cmd.Parameters.Add(new SqlParameter("@Province", txtBillingProvince.Text));
                cmd.Parameters.Add(new SqlParameter("@Country", txtBillingCountry.Text));
                cmd.Parameters.Add(new SqlParameter("@PostalCode", txtBillingPostal.Text));
                cmd.Connection.Open();

                cmd.ExecuteNonQuery();
            }
        }

        private string GenerateAuthNumber()
        {
            Guid auth;
            auth = Guid.NewGuid();
            string num = auth.ToString();
            num = num.Replace("-", " ");
            num = num.Replace(" ", "");
            string authNumber = num.Substring(0, 10);
            return authNumber;
            
        }

        private int CreateShippingAddress()
        {
            using(SqlConnection conn = new SqlConnection(strConn))
            {
                SqlCommand cmd = new SqlCommand("spCreateShippingAddress", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@Street", txtStreet.Text));
                cmd.Parameters.Add(new SqlParameter("@City", txtCity.Text));
                cmd.Parameters.Add(new SqlParameter("@Province", txtProvince.Text));
                cmd.Parameters.Add(new SqlParameter("@Country", txtCountry.Text));
                cmd.Parameters.Add(new SqlParameter("@PostalCode", txtPostal.Text));
                cmd.Parameters.Add(new SqlParameter("@CustomerID", Session["CustomerID"].ToString()));
                SqlParameter output = new SqlParameter("@AddressID", System.Data.SqlDbType.Int);
                output.Direction = System.Data.ParameterDirection.Output;
                cmd.Parameters.Add(output);
                cmd.Connection.Open();

                cmd.ExecuteNonQuery();
                return int.Parse(output.Value.ToString());
            }
        }

        private void CreateOrder( int addressID, string auth)
        {
            string payChoice;
            try
            {
                if(rdoPaypal.Checked == true)
                {
                    payChoice = "PP";
                }
                else
                {
                    payChoice = "CC";
                }
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    SqlCommand cmd = new SqlCommand("spCreateOrder", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@CustomerID", int.Parse(Session["CustomerID"].ToString())));
                    cmd.Parameters.Add(new SqlParameter("@CartID", int.Parse(Request.Cookies["CartID"].Value.ToString())));
                    cmd.Parameters.Add(new SqlParameter("@PayType", payChoice));
                    cmd.Parameters.Add(new SqlParameter("@BillingAddress", billingID));
                    cmd.Parameters.Add(new SqlParameter("@ShippingAddress", addressID));
                    cmd.Parameters.Add(new SqlParameter("@AuthNumber", auth));
                    cmd.Connection.Open();

                    cmd.ExecuteNonQuery();

                    master.masterMessage = "Order Created!";
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
        }

        private void CreateOrder(string auth)
        {
            string payChoice;
            try
            {
                if (rdoPaypal.Checked == true)
                {
                    payChoice = "PP";
                }
                else
                {
                    payChoice = "CC";
                }
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    SqlCommand cmd = new SqlCommand("spCreateOrder", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@CustomerID", int.Parse(Session["CustomerID"].ToString())));
                    cmd.Parameters.Add(new SqlParameter("@CartID", int.Parse(Request.Cookies["CartID"].Value.ToString())));
                    cmd.Parameters.Add(new SqlParameter("@PayType", payChoice));
                    cmd.Parameters.Add(new SqlParameter("@BillingAddress", billingID));
                    cmd.Parameters.Add(new SqlParameter("@ShippingAddress", billingID));
                    cmd.Parameters.Add(new SqlParameter("@AuthNumber", auth));
                    cmd.Connection.Open();

                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
        }

        private void SendOrderEmail()
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("orders@vidiots.com");
            mail.To.Add(new MailAddress(GetCustomerEmail()));
            mail.Subject = "Order Confirmation";
            mail.IsBodyHtml = true;
            mail.Body = "<h1>Your order has been created!</h1>";

            SmtpClient smtpClient = new SmtpClient("localhost");
            smtpClient.Send(mail);
        }

        private string GetCustomerEmail()
        {
            string email = "";
           SqlDataReader dr = default(SqlDataReader);
           using(SqlConnection conn = new SqlConnection(strConn))
           {
                SqlCommand cmd = new SqlCommand("spGetCustomerEmail", conn);
                cmd.Parameters.Add(new SqlParameter("@CustomerID", Session["CustomerID"]));
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Connection.Open();
                dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                if (dr.HasRows)
                {
                    dr.Read();
                    email = dr["EmailAddress"].ToString();
                }
           }

            return email;
        }
    }
}