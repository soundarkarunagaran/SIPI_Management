   M S B A M L   `   `   `  ����   SIPI_SL"    SIPI_SL.UI.Admission.ThanaUI   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35n jSAPBusinessObjects.WPF.ViewerShared, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml       � Title$  Thana UI��$	��426��$	��525��   	GrayWhite#��[   � ShowInTaskbar .   � WindowStartupLocation$ CenterScreen=�.���  � ColumnDefinitions �� .+��� $��
Thana Name��$
��Left=�$��	49,90,0,0q�$	��Top=�$��26��$	��102���� -   $��ThanaNameTextBox��$
��Left=�$��23��$��
172,93,0,0q� �� TextWrapping$
 Wrap=�$�� ��$	��Top=�$	��120���� $��Thana In Bangla��$
��Left=�$��
49,118,0,0q�$	��Top=�$��26��$	��102���� -   $��banglaThanaNameTextBox��$
��Left=�$��23��$��172,121,0,0q�$
 Wrap=�$�� ��$	��Top=�$	��120���� $��GroupBox��$
��Left=�$��
40,176,0,0q�$	��Top=�$	��184��$	��424��.��� $
��Left=�$	��162��$	��Top=�$	��426��$��0,0,-2,0q� �� $��2* ��� $
��211* �.+��� -   $��ThanalistView��$	��156��$
��Left=�$��2.269,6,0,0q�$	��Top=�$	��400��$��1��   alternatingListViewItemStyle#��[  �� AlternationCount$ 2�� � ContextMenu �� -   $��ZoneIformationList�� �� 	StaysOpen . 
������� J� BitmapEffect �� .@�m� -   $��EditThanaContextMenu��$
��Edit��m� -   $��RemoveThanaContextMenu��$��Remove��	 �� View	 �� 
 �� AllowsColumnReorder
 . .P��� $�� �� �� Width$ 0�� �� DisplayMemberBinding ��  �� Path$ Id��� $�� ��$ 0�� �� $ 
DistrictId��� $��District Name��$	 100�� �� $ DistrictName��� $��
Thana Name��$	 150�� �� $ 	ThanaName��� $��Thana In Bangla��$	 150�� �� $ BanglaThanaName��� -   $��submitButton��$
��Save��$
��Left=�$��343,149,0,0q�$	��Top=�$��75��$��22���� $��District Name��$
��Left=�$��	49,56,0,0q�$	��Top=�$��26��$��82���� -    ��Name$ districtCombobax��$
��Left=�$��
172,56,0,0q�$	��Top=�$	��120��$��22��  ComboBoxBGYellowGreen#��[ ���� .R���  �� Orientation$ 
Horizontal=�.+��� $��60������ *DistrictName+