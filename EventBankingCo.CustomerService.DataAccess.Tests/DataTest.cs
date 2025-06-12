using EventBankingCo.Core.DataAccess.Implementation;
using EventBankingCo.Core.DataAccess.Abstraction;
using EventBankingCo.Core.Logging.Abstraction;
using Moq;

namespace EventBankingCo.CustomerService.DataAccess.Tests
{
    public abstract class DataTest
    {
        /// <summary>
        /// This is the expected connection string if you are running in DEV and have deployed the EventBankingCo.CustomerService.Database project to a docker container.
        /// Follow the steps in the readme for the Database project if you still need to deploy the database.
        /// </summary>
        protected const string TestDatabaseConnectionString = "Server=localhost,1433;Database=CustomerService;User Id=sa;Password=Your!StrongP@ssw0rd123;Encrypt=False;";

        private readonly Mock<ICoreLogger<Core.DataAccess.Implementation.DataAccess>> _logger = new();

        protected readonly IDataAccess _dataAccess;

        protected DataTest()
        {
            var mockLoggerFactory = new Mock<ICoreLoggerFactory>();

            mockLoggerFactory.Setup(_ => _.Create(It.IsAny<Core.DataAccess.Implementation.DataAccess>()))
                             .Returns(_logger.Object);

            _dataAccess = new Core.DataAccess.Implementation.DataAccess(
                new SqlServerConnectionFactory(TestDatabaseConnectionString),
                mockLoggerFactory.Object
            );
        }
    }
}
