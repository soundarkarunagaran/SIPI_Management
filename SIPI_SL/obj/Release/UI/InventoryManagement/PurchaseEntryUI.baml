   M S B A M L   `   `   `  ����   SIPI_SL4    .SIPI_SL.UI.InventoryManagement.PurchaseEntryUI   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35n jSAPBusinessObjects.WPF.ViewerShared, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml       � Title$  Purchase Entry UI��$��514.483��$��1070.428�� � WindowStartupLocation$ CenterScreen=�   	GrayWhite#��[   � ShowInTaskbar .  .��� .+��� $��Product Collection��$
��Left=�$��	10,10,0,0q�$	��Top=�$	��445��$	��515��.��� $��	0,0,-2,-2q�.+��� $
��Left=�$��30��$��9,6,0,0q� �� TextWrapping$
 Wrap=�$	��Top=�$	��176���� -   $ ��productMasterEntryListView��$
��Left=�$	��378��$��9,37,0,0q�$	��Top=�$	��176�� �� View �� .P��� $��ID�� �� Width$ 0�� �� DisplayMemberBinding ��  �� Path$ Id��� $��Product Name��$
 Auto�� �� $ Product_Name��� $��
Brand Name��$
 Auto�� �� $ 	BrabdName��� $��Category Name��$
 Auto�� �� $ CategoryName��� $��CategoryName��$
 Auto�� �� $ CategoryName��� $��	Unit Type��$
 Auto�� �� $ UnitTypeName��� $��Stock In Hand��$
 Auto�� �� $ Stock_InHand��� $��Product��$
��Left=�$��
193,10,0,0q�$	��Top=�$	��116���� -   $��productNameTextBox��$
��Left=�$��30��$��	313,9,0,0q�$
 Wrap=�$	��Top=�$	��132��{�.  �� -   $��productIdTextBox��$
��Left=�$��30��$y�Hidden=�$��	587,9,0,0q�$
 Wrap=�$	��Top=�$��48��{�.  �� $��Category��$
��Left=�$��
192,37,0,0q�$	��Top=�$	��116���� -   $��categoryNameTextBox��$
��Left=�$��30��$��
313,40,0,0q�$
 Wrap=�$	��Top=�$	��132��{�.  �� -   $��categoryIdTextBox��$
��Left=�$��30��$y�Hidden=�$��
587,40,0,0q�$
 Wrap=�$	��Top=�$��48��{�.  �� $��Brand��$
��Left=�$��
193,75,0,0q�$	��Top=�$	��116���� -   $��brandNameTextbox��$
��Left=�$��30��$��
313,71,0,0q�$
 Wrap=�$	��Top=�$	��132��{�.  �� -   $��brandIdTextbox��$
��Left=�$y�Hidden=�$��30��$��
587,71,0,0q�$
 Wrap=�$	��Top=�$��48��{�.  �� -    ��Name$ unitTypeNameTextbox��$
��Left=�$��30��$��313,102,0,0q�$
 Wrap=�$	��Top=�$	��132��{�.  �� -	   $ unitTypeIdTextbox��$
��Left=�$y�Hidden=�$��30��$��587,102,0,0q�$
 Wrap=�$	��Top=�$��48��{�.  �� $��Number Of Product��$
��Left=�$��193,138,0,0q�$	��Top=�$	��116���� -
   $��productQuantityTextBox��$
��Left=�$��30��$��313,134,0,0q�$
 Wrap=�$	��Top=�$	��132���� -   $��QuantityPerPackTextBox��$
��Left=�$��30��$��450,134,0,0q�$
 Wrap=�$	��Top=�$��48���� $��Salable Quantity��$
��Left=�$��193,168,0,0q�$	��Top=�$	��116���� -   $��salableQuantityTextBox��$
��Left=�$��30��$��313,165,0,0q�$
 Wrap=�$	��Top=�$	��132��{�.  �� -   $ extraQuantityTextBox��$
��Left=�$��30��$��450,165,0,0q�$
 Wrap=�$	��Top=�$��48���� $��
Item Price��$
��Left=�$��193,199,0,0q�$	��Top=�$	��102���� -   $��itemPriceTextBox��$
��Left=�$��30��$��313,196,0,0q�$
 Wrap=�$	��Top=�$	��132��{�.  �� $��Total Price��$
��Left=�$��193,230,0,0q�$	��Top=�$	��102���� -   $��totalPriceTextBox��$
��Left=�$��30��$��313,228,0,0q�$
 Wrap=�$	��Top=�$	��132���� -   	 ��Name$	 	addButton��$��6q�$��ADD >>>��$
��Left=�$��420,385,0,0q�$	��Top=�$��78���� $��	Unit Type��$
��Left=�$��193,103,0,0q�$	��Top=�$	��116���� -   $��ifItempriceChickBox��$��Price��$
��Left=�$��450,205,0,0q�$	��Top=�$��48���� $��Purchase Details��$
��Left=�$��
844,10,0,0q�$	��Top=�$	��445��$	��208��.���� -   $��purchageListDetailsList��$
��Left=�$	��413��$��	10,10,0,0q�$	��Top=�$	��178��
 � ContextMenu
 �� -   $��purchageEntrySlip�� �� 	StaysOpen . 
������� J� BitmapEffect �� .@�m� -   $��SlipContextMenu��$
��Slip�� �� .P��� $��
Invoice No��$
 Auto�� �� $ 	InvoiceNo��� $��Purchase Date��$
 Auto�� �� $ PurchaseDate� �� StringFormat$ 
dd-MM-yyyy���� $��Purchaser Info��$
 Auto�� �� $ PurchaserInfo��� $��Total Price��$ 0�� �� $ SystemSerialNo��� $��Stock Entry��$
��Left=�$��
530,10,0,0q�$	��Top=�$	��445��$	��309��.��� $��0,0,-2,0q�.+��� $��
Invoice No��$��
23,5,174,0q�$	��Top=��� -   $��invoiceNoTextbox��$
��Left=�$��30��$��	143,4,0,0q�$
 Wrap=�$	��Top=�$	��146���� $
��Date��$��23,31,161,0q�$	��Top=�(  "System.Windows.Controls.DatePicker  -   $��StockEntryDate��$
��Left=�$��
143,36,0,0q�$	��Top=�$	��146���� $��Purchaser Info��$
��Left=�$��	23,62,0,0q�$	��Top=�$	��102���� -   $��purchaserInfoTextBox��$
��Left=�$��30��$��
143,62,0,0q�$
 Wrap=�$	��Top=�$	��146���� -   $��stockEntryListview��$
��Left=�$	��259��$��	14,93,0,0q�$	��Top=�$	��276��
 �� -   $��purchageInformationList�� . 
������� �� .@�m� -   $#��RemoveSelectedItemContextMenu��$��Remove�� �� .P��� $��ID��$ 0�� �� *Id+�� $��Product Name��$
 Auto�� �� *ProductName+�� $��
Product ID��$ 0�� �� *	ProductId+�� $��Number Of Product��$
 Auto�� �� *NumberOfProduct+�� $��Per Pack Quantity��$
 Auto�� �� *EveryPackQuantity+�� $��Extra Quantity��$
 Auto�� �� *ExtraQuantity+�� $��Salable Quantity��$
 Auto�� �� *SalableQuantity+�� $��	ItemPrice��$
 Auto�� �� *	ItemPrice+�� $��Total Price��$
 Auto�� �� *
TotalPrice+�� -   $��insertButton��$��6q�$
��Save��$��Right=�$	��Top=�$��78��$��
0,383,10,0q��� -   $��clearButton��$��6q�$��Clear��$��Right=�$	��Top=�$��78��$��
0,383,90,0q��� -   $ grandTotalPriceTextBox��$
��Left=�$��24��$��214,354,0,0q�$
 Wrap=�$	��Top=�$��76���� $��Total��$
��Left=�$��168,352,0,0q�$	��Top=�$��41���� -   $ systemSerialNoTextbox��$
��Left=�$��30��$��	143,4,0,0q�$
 Wrap=�$	��Top=�$	��222��$y�Hidden=�