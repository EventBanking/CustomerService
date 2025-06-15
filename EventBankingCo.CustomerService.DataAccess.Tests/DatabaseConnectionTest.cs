using Microsoft.Data.SqlClient;

namespace EventBankingCo.CustomerService.DataAccess.Tests
{
    public class DatabaseConnectionTest : DataTest
    {
        [Fact]
        public void SqlConnection_CanOpenConnection()
        {
            using var  connection = new SqlConnection(TestDatabaseConnectionString);

            connection.Open();

            Assert.True(connection.State == System.Data.ConnectionState.Open);

            connection.Close();
        }

        [Fact]
        public void ForceFailure()
        {
            Assert.True(false);
        }
    }
}
