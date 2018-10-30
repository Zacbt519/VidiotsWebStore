using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
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
        private int billingID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsTemplate)this.Master;
            string customerID = Session["customerID"].ToString();
            if (!IsPostBack)
            {
                PopulateCountries();
                GetBillingAddress(customerID);
            }
        }

        private void PopulateCountries()
        {
            ddlBillingCountry.Items.Add("Canada");
            ddlBillingCountry.Items.Add("USA");
            ddlCountry.Items.Add("Canada");
            ddlCountry.Items.Add("USA");
        }
        protected void billingProvinces()
        {
            if (ddlBillingCountry.SelectedValue == "Canada")
            {
                string[] prov = { "AB", "BC", "MB", "NB", "NL", "NT", "NS", "NU", "ON", "PE", "QC", "SK", "YT" };
                ddlBillingProvince.DataSource = prov;
                ddlBillingProvince.DataBind();
                ddlBillingProvince.Enabled = true;
                revBillingZip.ValidationExpression = @"^([a-zA-Z]\d[a-zA-Z]( )?\d[a-zA-Z]\d)$";
            }
            else if (ddlBillingCountry.SelectedValue == "USA")
            {
                string[] states = { "AL", "AK", "AS", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FM", "FL", "GA", "GU", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MH", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PW", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VI", "VA", "WA", "WV", "WI", "WY" };
                ddlBillingProvince.DataSource = states;
                ddlBillingProvince.DataBind();
                ddlBillingProvince.Enabled = true;
                revBillingZip.ValidationExpression = @"^\d{5}$";
            }
            else
            {
                ddlBillingProvince.SelectedIndex = 0;
                ddlBillingProvince.DataSource = null;
                ddlBillingProvince.DataBind();
                ddlBillingProvince.Items.Insert(0, "---Select a Province/State");
                ddlBillingProvince.Enabled = false;
            }
        }
        protected void ddlBillingCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            billingProvinces();
        }

        protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCountry.SelectedValue == "Canada")
            {
                string[] prov = { "AB", "BC", "MB", "NB", "NL", "NT", "NS", "NU", "ON", "PE", "QC", "SK", "YT" };
                ddlProvince.DataSource = prov;
                ddlProvince.DataBind();
                ddlProvince.Enabled = true;
                revZip.ValidationExpression = @"^([a-zA-Z]\d[a-zA-Z]( )?\d[a-zA-Z]\d)$";
            }
            else if (ddlCountry.SelectedValue == "USA")
            {
                string[] states = { "AL", "AK", "AS", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FM", "FL", "GA", "GU", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MH", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PW", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VI", "VA", "WA", "WV", "WI", "WY" };
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
                        ddlBillingCountry.SelectedValue = dr["Country"].ToString();
                        billingProvinces();
                        ddlBillingProvince.SelectedValue = dr["Province"].ToString();
                        txtBillingPostal.Text = dr["PostalCode"].ToString();
                        billingID = int.Parse(dr["AddressID"].ToString());

                        Response.Cookies["billingID"].Value = billingID.ToString();
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
                    
                }
                else
                {
                    UpdateBillingAddress();
                    CreateOrder(GenerateAuthNumber());
                    
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
                cmd.Parameters.Add(new SqlParameter("@Province", ddlBillingProvince.SelectedValue.ToString()));
                cmd.Parameters.Add(new SqlParameter("@Country", ddlBillingCountry.SelectedValue.ToString()));
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
                cmd.Parameters.Add(new SqlParameter("@Province", ddlProvince.SelectedValue.ToString()));
                cmd.Parameters.Add(new SqlParameter("@Country", ddlCountry.SelectedValue.ToString()));
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
            int billingID = int.Parse(Request.Cookies["billingID"].Value.ToString());
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
                    SqlParameter output = new SqlParameter("@OrderID", System.Data.SqlDbType.SmallInt);
                    output.Direction = System.Data.ParameterDirection.Output;
                    cmd.Parameters.Add(output);
                    cmd.Connection.Open();

                    cmd.ExecuteNonQuery();
                    int order = int.Parse(output.Value.ToString());
                    SendOrderEmail(auth,order);
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
            int billingID = int.Parse(Request.Cookies["billingID"].Value.ToString());
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
                    SqlParameter output = new SqlParameter("@OrderID", System.Data.SqlDbType.SmallInt);
                    output.Direction = System.Data.ParameterDirection.Output;
                    cmd.Parameters.Add(output);
                    cmd.Connection.Open();

                    cmd.ExecuteNonQuery();
                    int order = int.Parse(output.Value.ToString());
                    SendOrderEmail(auth, order);
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
        }

        private void SendOrderEmail(string auth, int orderNum)
        {

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("orders@vidiots.com");
            mail.To.Add(new MailAddress(GetCustomerEmail()));
            mail.Subject = "Order Confirmation";
            mail.IsBodyHtml = true;
            mail.Body = "<h1>Your order has been created!</h1><br/><br/><h3>Order Number: " + auth + "</h3><br><br><h2>Items Ordered:</h2><br/><br/>";
            string items = PopulateItems(orderNum);
            mail.Body += items;
            if(chkShipping.Checked == true)
            {
                mail.Body += "<br/><h4>Delivery Address</h4><br/><br/><p>" + txtStreet.Text + "<br/>" + txtCity.Text + ", " + ddlProvince.SelectedValue.ToString() + "<br/>" + ddlCountry.SelectedValue.ToString() + "<br/>" + txtPostal.Text + "</p>";
                mail.Body += "<br/><a href='http://localhost:49487/OrderDetails.aspx?orderId=" + orderNum + "'> View Order </a>";
                mail.Body += "<br/><h3>Order Details:</h3><br><p>Order Subtotal: " + string.Format("{0:C}", Session["orderSubtotal"]) + "</p><br/> <p> Tax: " + string.Format("{0:C}", Session["taxAmount"]) + "</p><br/><p>Shipping Amount: " + string.Format("{0:C}", Session["shipping"]) + "</p><br/><p> Order Total: " + string.Format("{0:C}", Session["total"]) + "</p>";
                SmtpClient smtpClient = new SmtpClient("localhost");
                smtpClient.Send(mail);
                master.masterMessage = "Email Sent";
            }

            if(chkShipping.Checked == false)
            {
                mail.Body += "<br/><h4>Delivery Address</h4><br/><br/><p>"+ txtBillingStreet.Text +"<br/>" + txtBillingCity.Text + ", " + ddlBillingProvince.SelectedValue.ToString()  + "<br/>" + ddlBillingCountry.SelectedValue.ToString() + "<br/>" + txtBillingPostal.Text + "</p>";
                mail.Body += "<br/><a href='http://localhost:49487/OrderDetails.aspx?orderId=" + orderNum + "'> View Order </a>";
                mail.Body += "<br/><h3>Order Details:</h3><br><p>Order Subtotal: " + string.Format("{0:C}", Session["orderSubtotal"]) + "</p><br/> <p> Tax: " + string.Format("{0:C}", Session["taxAmount"]) + "</p><br/><p>Shipping Amount: " + string.Format("{0:C}", Session["shipping"]) + "</p><br/><p> Order Total: " + string.Format("{0:C}", Session["total"]) + "</p>";
                SmtpClient smtpClient = new SmtpClient("localhost");
                smtpClient.Send(mail);
                master.masterMessage = "Email Sent";
            }


            Request.Cookies["cartID"].Expires = DateTime.Now.AddDays(-3);
            Response.Cookies["cartID"].Expires = DateTime.Now.AddDays(-3);
            Response.Cookies["cartID"].Value = (0).ToString();
        }

        private string PopulateItems(int orderId)
        {
            string items = string.Empty;
            
            using(SqlConnection conn = new SqlConnection(strConn))
            {
                DataTable dt = new DataTable();
                SqlCommand cmd = new SqlCommand("spGetItemsFromOrderHistory",conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@CartID", int.Parse(Request.Cookies["CartID"].Value.ToString())));
                cmd.Parameters.Add(new SqlParameter("@OrderHistoryID", orderId));
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                cmd.Connection.Open();
                da.Fill(dt);

                foreach(DataRow row in dt.Rows)
                {
                    items += "<p>"+ row["ProductName"].ToString() + "</p>";
                }

                return items;
            }
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