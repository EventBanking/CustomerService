using EventBankingCo.Core.DataAccess.DataRequests;

namespace EventBankingCo.CustomerService.DataAccess.DataRequests.Customer
{
    public class DeleteCustomer : SqlCommand
    {
        private readonly string? _memberId;

        private readonly int? _id;

        public DeleteCustomer(int id)
        {
            _id = id;
        }

        public DeleteCustomer(string memberId)
        {
            _memberId = memberId;
        }

        public object Identifier => _id.HasValue? _id.Value : _memberId!;

        public override object? GetParameters() => this;
        
        public override string GetSql() => $"DELETE FROM {Table.Customers} WHERE Id = @Identifier";
    }
}
