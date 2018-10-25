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
                        streetAddress.InnerText = dr["Street"].ToString();
                        cityAndProvince.InnerText = dr["City"].ToString() + ", " + dr["Province"].ToString();
                        country.InnerText = dr["Country"].ToString();
                        postalCode.InnerText = dr["PostalCode"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            finally
            {
                master.masterMessage = "Address Retrieved";
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
                if(chkShipping.Checked == true)
                {
                    CreateOrder(CreateShippingAddress());
                }
                else
                {

                }
                
                SendOrderEmail();
            }
            catch(Exception ex)
            {
                master.masterMessage = ex.Message;
            }
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
                SqlParameter output = new SqlParameter("@AddressID", System.Data.SqlDbType.Int);
                output.Direction = System.Data.ParameterDirection.Output;
                cmd.Parameters.Add(output);

                cmd.ExecuteNonQuery();
                return int.Parse(output.Value.ToString());
            }
        }

        private void CreateOrder( int addressID)
        {
            try
            {
                SqlDataReader dr = default(SqlDataReader);
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    SqlCommand cmd = new SqlCommand("spCreateOrder", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    
                    conn.Open();
                   
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
        }

        private void SendOrderEmail(string customerEmail)
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("orders@vidiots.com");
            mail.To.Add(new MailAddress(customerEmail));
            mail.Subject = "Order Confirmation";
            mail.IsBodyHtml = true;

            SmtpClient smtpClient = new SmtpClient("localhost");
            smtpClient.Send(mail);
        }
    }
}