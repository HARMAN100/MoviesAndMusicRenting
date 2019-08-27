using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MoviesAndMusicRenting
{
    class NetworkingHelpers
    {

        public static string HostConfig()
        {
            string dataSource = "DESKTOP-DJ66H0J\\SQLEXPRESS";
            return @"Data Source="+ dataSource +"; Initial Catalog=rental_store; Integrated Security=True";
        }

        // This function can be used to add items to any table
        public static void AddToTable(string TableName, string columns, string values, string[] inputs, string[] fieldValues)
        {
            using (SqlConnection conn = new SqlConnection(NetworkingHelpers.HostConfig()))
            {
                // Open Connection
                conn.Open();

                SqlCommand _cmd = new SqlCommand("INSERT INTO " + TableName + columns + " VALUES "+ values, conn);
                for (int index = 0; index < inputs.Length; index++)
                {
                    _cmd.Parameters.AddWithValue(inputs[index], fieldValues[index]);
                }
                _cmd.ExecuteNonQuery();
            }
        }

        // This function can be used to update contents of any table
        public static void UpdateTable(string TableName, string values, string condition, string[] fieldNames, string[] inputValues)
        {
            using(SqlConnection conn = new SqlConnection(HostConfig()))
            {
                // Open Connection
                conn.Open();

                string query = "UPDATE " + TableName + " SET " + values + " WHERE " + condition;
                SqlCommand _cmd = new SqlCommand(query, conn);
                for (int index = 0; index < fieldNames.Length; index++)
                {
                    _cmd.Parameters.AddWithValue(fieldNames[index], inputValues[index]);
                }
                _cmd.ExecuteNonQuery();
            }
        }

        // This function can be used to delete items from any table
        public static void DeleteFromTable(string table, string columnName, string rowID)
        {
            using(SqlConnection conn = new SqlConnection(HostConfig()))
            {
                // Open Connection
                conn.Open();

                string query = "DELETE FROM " + table + " WHERE " + columnName + "=" + rowID;
                SqlCommand _cmd = new SqlCommand(query, conn);
                _cmd.ExecuteNonQuery();
            }
        }

        // Add to DataGridView
        public static void AddToDataGridView(string table, DataGridView view, MetroFramework.Controls.MetroTile tile)
        {
            using (SqlConnection conn = new SqlConnection(NetworkingHelpers.HostConfig()))
            {
                // Establish Connection
                conn.Open();

                SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM " + table, conn);
                DataTable dataTable = new DataTable();
                dataTable.Clear();
                adapter.Fill(dataTable);

                view.AutoGenerateColumns = false;
                view.DataSource = dataTable;

                if (table == "Customers")
                {
                    if (view.Rows.Count - 1 > 0)
                    {
                        tile.Text = (view.Rows.Count - 1).ToString() + " Registered Customer(s)";
                    }
                    else
                    {
                        tile.Text = "0 Registered Customers";
                    }
                }
                else if (table == "Movies")
                {
                    if (view.Rows.Count - 1 > 0)
                    {
                        tile.Text = (view.Rows.Count - 1).ToString() + " Movie(s) in Store";
                    }
                    else
                    {
                        tile.Text = "0 Movies in Store";
                    }
                }
                else
                {
                    if (view.Rows.Count - 1 > 0)
                    {
                        tile.Text = (view.Rows.Count - 1).ToString() + " Movie(s) Rented";
                    }
                    else
                    {
                        tile.Text = "0 Movies Rented";
                    }
                }
            }
        }

        // CONDITIONS FOR DELETING MOVIES OR CUSTOMERS
        public static int GetUserRentedMovies(int CustomerID)
        {
            List<string> MoviesList = new List<string>();
            using(SqlConnection conn = new SqlConnection(HostConfig()))
            {
                // Open Connection
                conn.Open();

                SqlCommand _cmd = new SqlCommand("SELECT * FROM Rented WHERE CustomerID=@id", conn);
                _cmd.Parameters.AddWithValue("@id", CustomerID);
                SqlDataReader reader;
                reader = _cmd.ExecuteReader();
                while(reader.Read())
                {
                    MoviesList.Add(reader["RentalID"].ToString());
                }
                reader.Close();
                return MoviesList.Count();
            }
        }

        public static int GetMovieOnRent(int MovieID)
        {
            List<string> MoviesList = new List<string>();
            using (SqlConnection conn = new SqlConnection(HostConfig()))
            {
                // Open Connection
                conn.Open();

                SqlCommand _cmd = new SqlCommand("SELECT * FROM Rented WHERE MovieID=@id", conn);
                _cmd.Parameters.AddWithValue("@id", MovieID.ToString());
                SqlDataReader reader;
                reader = _cmd.ExecuteReader();
                while (reader.Read())
                {
                    MoviesList.Add(reader["RentalID"].ToString());
                }
                reader.Close();
                return MoviesList.Count();
            }
        }
    }
}
