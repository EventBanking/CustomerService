using EventBankingCo.Core.Domain.Enums;
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

        [Fact]
        public async Task IsMemberIdExisting_ReturnsTrue_WhenMemberIdExists()
        {
            // Arrange
            var existingMemberId = "existing-member-id";

            await _dataAccess.ExecuteAsync(new InsertCustomer(
                memberId: existingMemberId,
                firstName: "John",
                lastName: "Doe",
                email: "IsMemberIdExisting@ReturnsTrue_WhenMemberIdExists.com",
                phoneNumber: "1234567890",
                verificationStatus: VerificationStatus.Verified
            ));

            // Act
            var result = await _dataAccess.FetchAsync(new IsMemberIdExisting(existingMemberId));

            // Assert
            Assert.True(result);

            // Cleanup
            await _dataAccess.ExecuteAsync(new DeleteCustomer(existingMemberId));
        }
    }
}
