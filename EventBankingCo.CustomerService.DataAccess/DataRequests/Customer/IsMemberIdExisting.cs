using EventBankingCo.Core.DataAccess.DataRequests;

namespace EventBankingCo.CustomerService.DataAccess.DataRequests.Customer
{
    public class IsMemberIdExisting : SqlFetch<bool>
    {
        public IsMemberIdExisting(string memberId)
        {
            MemberId = memberId;
        }

        public string MemberId { get; set; }

        public override object? GetParameters() => this;

        public override string GetSql() =>
            $@"
                SELECT 
                    CASE WHEN EXISTS 
                        ( SELECT 1 FROM {Table.Customers} WHERE MemberId = @MemberId )
                    THEN 1 ELSE 0 END; 
            ";
    }
}
