   M S B A M L   `   `   `  ����   SIPI_SL!    SIPI_SL.UI.Admission.PostUI   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35n jSAPBusinessObjects.WPF.ViewerShared, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml       � Title$  Post UI��$��391.209��$��478.022��   	GrayWhite#��[   � ShowInTaskbar .   � WindowStartupLocation$ CenterScreen=�.���  � RowDefinitions �� .+��� $��
Thana Name��$
��Left=�$��	24,48,0,0q�$	��Top=�$��26��$	��102���� -    ��Name$ postNameTextBox��$
��Left=�$��25��$��
143,82,0,0q� �� TextWrapping$
 Wrap=�$�� ��$	��Top=�$	��159���� $��	Post Name��$
��Left=�$��	24,81,0,0q�$	��Top=�$��26��$	��102���� -   $ postCodeTextBox��$
��Left=�$��24��$��143,110,0,0q�$
 Wrap=�$�� ��$	��Top=�$	��159���� $��	Post Code��$
��Left=�$��
24,107,0,0q�$	��Top=�$��26��$	��102���� -   $ banglaPostNameTextBox��$
��Left=�$��24��$��143,138,0,0q�$
 Wrap=�$�� ��$	��Top=�$	��159���� $��Post in Bnangla��$
��Left=�$��
24,133,0,0q�$	��Top=�$��34��$	��102���� $��GroupBox��$
��Left=�$��
10,167,0,0q�$	��Top=�$	��184��$	��436��$��2��.��� $
��Left=�$	��162��$	��Top=�$	��426��$��0,0,-2,0q� � ColumnDefinitions �� $��2* ��� $
��211* �.+��� -    ��Name$ postlistView��$	��156��$
��Left=�$��2,6,0,0q�$	��Top=�$	��420��$��1��   alternatingListViewItemStyle#��[  �� AlternationCount$ 2��	 � ContextMenu	 �� -   
 ��Name$
 ZoneIformationList�� �� 	StaysOpen . 
������� J� BitmapEffect �� .@�m� -    m�Name$ EditThanaContextMenu��$
��Edit��m� -   $ RemoveThanaContextMenu��$��Remove�� �� View ��  �� AllowsColumnReorder . .P��� $�� �� �� Width$ 0�� �� DisplayMemberBinding �� *Id+�� $��	Post Name��$	 100�� �� *
PostName+�� $��	Post Code��$	 100�� �� *
PostCode+�� $��Post In Bangla��$	 100�� �� *BanglaPostName+�� $��District Name��$	 100�� �� *DistrictName+�� $��
Thana Name��$	 100�� �� *	ThanaName+�� -    ��Name$ submitButton��$
��Save��$
��Left=�$��314,103,0,0q�$	��Top=�$��75��$��22���� $��District Name��$��24,17,364,0q�$	��Top=��� -	    ��Name$ districtCombobax�� �� 
IsEditable .  w� TextPath$ DistrictName��$��143,12,168,0q�$	��Top=�  ComboBoxBGYellowGreen#��[ $
��Auto������ .R���  �� Orientation$ 
Horizontal=�.+��� $��60������ *DistrictName+�� -
   $ thanaCombobax�� . $ 	ThanaName��$��143,47,168,0q�$	��Top=�#��[ $
��Auto������ .R��� $ 
Horizontal=�.+��� $��60������ *	ThanaName+