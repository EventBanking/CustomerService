using EventBankingCo.CustomerService.DataAccess.DataRequests.Customer;

namespace EventBankingCo.CustomerService.DataAccess.Tests.DataRequests.Customer
{
    public class IsMemberIdExistingTests : DataTest
    {
        [Fact]
        public async Task IsMemberIdExisting_ReturnsFalse_WhenMemberIdDoesNotExist()
        {
            // Arrange
            var request = new IsMemberIdExisting("non-existing-member-id");

            // Act
            var result = await _dataAccess.FetchAsync(request);
            
            // Assert
            Assert.False(result);
        }
    }
}
