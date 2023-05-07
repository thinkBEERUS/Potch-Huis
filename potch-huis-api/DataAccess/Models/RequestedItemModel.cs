using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models;

public class RequestedItemModel
{
    public string? Name { get; set; }
    public string? Quantity { get; set; }
    public string? Value { get; set; }
    public string? RequestNumber { get; set; }
    public string? StockNumber { get; set; }
    public string? RequestedItemNumber { get; set; }
    public string? ActualQuantity { get; set; }
    public int Id { get; set; }
}
