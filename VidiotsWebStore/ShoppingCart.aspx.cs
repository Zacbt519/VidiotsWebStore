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
    public partial class ShoppingCart : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsTemplate)this.Master;
            if (!IsPostBack)
            {
                string from = Request.QueryString["cart"];
                if (from == "1")
                {
                    if (Request.Cookies["cartID"] != null)
                    {
                        string cartID = Request.Cookies["cartID"].Value;
                        DisplayCartItem(cartID);
                    }
                    else
                    {
                        string cartID = CreateNewCart();
                        Response.Cookies["cartID"].Value = cartID;
                        Response.Cookies["cartID"].Expires = DateTime.Now.AddHours(1);
                        DisplayCartItem(cartID);
                    }
                }
                else
                {
                    if (Request.Cookies["cartID"] != null)
                    {
                        string cartID = Request.Cookies["cartID"].Value;
                        AddToCart(cartID);
                        DisplayCartItem(cartID);
                    }
                    else
                    {
                        string cartID = CreateNewCart();
                        AddToCart(cartID);
                        Response.Cookies["cartID"].Value = cartID;
                        Response.Cookies["cartID"].Expires = DateTime.Now.AddHours(1);
                        DisplayCartItem(cartID);
                    }
                }
            }
        }

        private void DisplayCartItem(string cartID)
        {
            try
            {
                SqlDataReader dr = default(SqlDataReader);
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    SqlCommand cmd = new SqlCommand("spGetCartItems", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@CartID", int.Parse(cartID)));
                    conn.Open();

                    dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        grvCart.DataSource = dr;
                        grvCart.DataBind();
                        CalculateSubTotal();
                       
                    }
                    else
                    {
                        grvCart.DataSource = null;
                        grvCart.DataBind();
                       
                    }
                }
            }
            catch(Exception ex)
            {
                master.masterMessage = ex.Message;
            }
        }

        private void CalculateSubTotal()
        {
            double orderSubtotal = 0;
            foreach(GridViewRow row in grvCart.Rows)
            {
                if (row.Cells[4].Text.Contains("$"))
                {
                    string itemSub = row.Cells[4].Text.Replace('$', ' ');
                    orderSubtotal += double.Parse(itemSub);
                }
                else
                {
                    orderSubtotal += double.Parse(row.Cells[4].Text);
                }
            }

            lblOrderSubtotal.Text += String.Format("{0:c}", orderSubtotal);
            CalculateShipping(orderSubtotal);
            CalculateOrderTotal(orderSubtotal, CalculateShipping(orderSubtotal));
        }

        private double CalculateShipping(double orderSubtotal)
        {
            double shippingCost = 0;
            if(orderSubtotal <= 35.00)
            {
                shippingCost = 7.00;
            }
            else if(orderSubtotal > 35.00 && orderSubtotal <= 75.00)
            {
                shippingCost = 12.00;
            }
            else
            {
                shippingCost = 0.00;
            }

            return shippingCost;
        }

        private void CalculateOrderTotal(double orderSubtotal, double shipping)
        {
            double taxAmount = (orderSubtotal * 1.15) - orderSubtotal;
            lblShippingCost.Text += String.Format("{0:c}", shipping);
            lblTax.Text += String.Format("{0:c}", taxAmount);
            double total = (orderSubtotal + shipping + taxAmount);
            lblOrderTotal.Text += String.Format("{0:c}", total);

        }

        private string CreateNewCart()
        {
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                SqlCommand cmd = new SqlCommand("spCreateCart", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter output = new SqlParameter("@CartID", System.Data.SqlDbType.Int);
                output.Direction = System.Data.ParameterDirection.Output;
                cmd.Parameters.Add(output);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;



                cmd.Connection.Open();

                cmd.ExecuteNonQuery();
                string id = output.Value.ToString();
                return id;
            }
        }

        private void AddToCart(string cartID)
        {
            try
            {
                string prodId = Request.Cookies["productID"].Value;
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    SqlCommand cmd = new SqlCommand("spAddItemToCart", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@CartID", int.Parse(cartID)));
                    cmd.Parameters.Add(new SqlParameter("@ProductID", int.Parse(prodId)));
                    cmd.Parameters.Add(new SqlParameter("@Quantity", 1));

                    cmd.Connection.Open();

                    cmd.ExecuteNonQuery();
                }
            }
            catch(Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            finally
            {
                master.masterMessage = "Item added to cart";
            }
            
        }

        private void DeleteFromCart(string cartID, string prodID)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    SqlCommand cmd = new SqlCommand("spRemoveFromCart", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@CartID", int.Parse(cartID)));
                    cmd.Parameters.Add(new SqlParameter("@ProductID", int.Parse(prodID)));

                    cmd.Connection.Open();

                    cmd.ExecuteNonQuery();
                    lblOrderSubtotal.Text = "Order Subtotal:";
                    lblOrderTotal.Text = "Order Total:";
                    lblShippingCost.Text = "Shipping Cost:";
                    lblTax.Text = "Tax:";
                    DisplayCartItem(cartID);
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            finally
            {
                master.masterMessage = "Item deleted from cart";
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/CustomerLogin.aspx?fromCheckOut=1");
        }

        protected void btnUpdateCart_Click(object sender, EventArgs e)
        {
            int i = 0;
            foreach (GridViewRow row in grvCart.Rows)
            {
                
                CheckBox chk = (CheckBox)row.FindControl("Remove");

                if(chk.Checked == true)
                {
                    string prodId = grvCart.Rows[i].Cells[0].Text;
                    string cartID = Request.Cookies["cartID"].Value;

                    DeleteFromCart(cartID, prodId);
                }

                i++;
            }

            int x = 0;
            foreach (GridViewRow row in grvCart.Rows)
            {
                
                TextBox txt = (TextBox)row.FindControl("Quantity");

                if(int.TryParse(txt.Text, out int quantity))
                {
                    if(quantity == 0)
                    {
                        string prodId = grvCart.Rows[x].Cells[0].Text;
                        string cartID = Request.Cookies["cartID"].Value;

                        DeleteFromCart(cartID, prodId);
                    }
                    else
                    {
                        string prodId = grvCart.Rows[x].Cells[0].Text;
                        string cartID = Request.Cookies["cartID"].Value;

                        UpdateQuantity(cartID, prodId, quantity);
                    }
                }
                i++;
            }
        }

        private void UpdateQuantity(string cartID, string prodId, int quantity)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    SqlCommand cmd = new SqlCommand("spUpdateQuantity", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@CartID", int.Parse(cartID)));
                    cmd.Parameters.Add(new SqlParameter("@ProductID", int.Parse(prodId)));
                    cmd.Parameters.Add(new SqlParameter("@Quantity", quantity));

                    cmd.Connection.Open();

                    cmd.ExecuteNonQuery();
                    lblOrderSubtotal.Text = "Order Subtotal: ";
                    lblOrderTotal.Text = "Order Total: ";
                    lblShippingCost.Text = "Shipping Cost: ";
                    lblTax.Text = "Tax: ";
                    DisplayCartItem(cartID);

                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            finally
            {
                master.masterMessage = "Item Quantity Updated";
            }
        }
    }
}