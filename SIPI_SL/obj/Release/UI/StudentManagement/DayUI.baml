   M S B A M L   `   `   `  ����   SIPI_SL(    "SIPI_SL.UI.StudentManagement.DayUI   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35n jSAPBusinessObjects.WPF.ViewerShared, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml       � Title$  Day UI��$	��426��$	��525��   	GrayWhite#��[   � ShowInTaskbar .  .���  � ColumnDefinitions .+��� $	��Day��$
��Left=�$��	49,73,0,0q�$	��Top=�$��26��$	��102���� -   $��
dayTextBox��$
��Left=�$��32��$��
151,68,0,0q� �� TextWrapping$
 Wrap=�$�� ��$	��Top=�$	��139���� $	��Day��$
��Left=�$��
40,176,0,0q�$	��Top=�$	��184��$	��250��.��� $
��Left=�$	��157��$	��Top=�$	��240��$��0,0,-2,0q� �� $��2* ��� $
��211* �.+��� -   $��daylistView��$	��158��$
��Left=�$��11,0,0,0q�$	��Top=�$	��213��$��1�� � ContextMenu �� -   $��ZoneIformationList�� �� 	StaysOpen . 
������� J� BitmapEffect �� .@�m� -   $��EditDistrictContextMenu��$
��Edit��m� -   $��RemoveDistrictContextMenu��$��Remove�� �� View ��  �� AllowsColumnReorder . .P��� $�� ��	 �� Width$	 0��
 �� DisplayMemberBinding
 ��  �� Path$ Id��� $	��Day��$		 100��
 �� $ DaySeveneven��� $��Day In Bnagla��$		 100��
 �� $ 	BanglaDay��� -   $��
saveButton��$
��Save��$
��Left=�$��215,149,0,0q�$	��Top=�$��75��$��22���� $��Day in Bangla��$
��Left=�$��
47,110,0,0q�$	��Top=�$��26��$	��102���� -    ��Name$ banglaDayTextBox��$
��Left=�$��31��$��151,105,0,0q�$
 Wrap=�$�� ��$	��Top=�$	��139���� $
��Year��$
��Left=�$��
302,73,0,0q�$	��Top=�$��26��$��80���� -   $ YearTextBox��$
��Left=�$��32��$��
387,67,0,0q�$
 Wrap=�$�� ��$	��Top=�$��94�� J� RenderTransformOrigin$ -0.076,0.44&��� -	    ��Name$ saveYearButton��$��	Save Year��$
��Left=�$��406,149,0,0q�$	��Top=�$��75��$��22���� $
��Year��$
��Left=�$��302,176,0,0q�$	��Top=�$	��184��$	��179��.��� $
��Left=�$	��154��$	��Top=�$	��169��$��0,0,-2,0q� �� $��2* ��� $
��211* �.+��� -
    ��Name$ yearlistView��$	��154��$
��Left=�$��11,0,0,0q�$	��Top=�$	��146��$��1�� �� -    ��Name$ ZoneIformationList1�� . 
������� �� .@�m� -    m�Name$ RemoveYearContextMenu��$��Remove�� ��  . .P��� $�� ��$	 0��
 �� *Id+�� $
��Year��$		 150��
 �� *Year+