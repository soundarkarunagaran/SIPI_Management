   M S B A M L   `   `   `  ����   SIPI_SL"    SIPI_SL.UI.Admission.BatchUI   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35n jSAPBusinessObjects.WPF.ViewerShared, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml       � Title$  BatchUI��$��420.596��$��571.796��   	GrayWhite#��[   � ShowInTaskbar .   � WindowStartupLocation$ CenterScreen=�.��� .+��� $��Batch��$
��Left=�$��
127,15,0,0q�$	��Top=�$	��198��$	��294��$
��Bold"�.��� .+��� $
��Year��$
��Left=�$��26��$	��Top=�$��75��$��	10,50,0,0q� J� RenderTransformOrigin$ 3.342,-0.195&��� $��Batch��$
��Left=�$��35��$	��Top=�$��80��$��	10,10,0,0q��� -   $��batchTextBox��$��114,10,10,0q�$��28��$	��Top=��� -   $��yearTextBox��$��114,50,10,0q�$��28��$	��Top=��� -   $��submitButton��$��131,0,10,10q�$
��Save��$��28��$��Bottom=�$ 
0.909,2.21&��� $��Batch in Bangla��$
��Left=�$��26��$	��Top=�$��99��$��	10,83,0,0q�$ 3.342,-0.195&��� -    ��Name$ banglaBatchTextBox��$��114,83,10,0q�$��28��$	��Top=��� $��Batch��$
��Left=�$��
27,213,0,0q�$	��Top=�$	��167��$	��486��.��� $
��Left=�$	��137��$	��Top=�$	��476��$��0,0,-2,0q� � ColumnDefinitions �� $��2* ��� $
��211* �.+��� -   $��batchlistView��$	��117��$��	10,10,0,0q�$	��Top=�$��1��$
��Left=�$	��452��   alternatingListViewItemStyle#��[  �� AlternationCount$ 2�� � ContextMenu �� -   $��ZoneIformationList�� �� 	StaysOpen . 
�������	 J� BitmapEffect	 �� .@�m� -   $��EditDepartmentContextMenu��$
��Edit��m� -   $!��RemoveDepartmentContextMenu��$��Remove��
 �� View
 ��  �� AllowsColumnReorder . .P��� $�� �� �� Width$ 0�� �� DisplayMemberBinding ��  �� Path$ Id��� $��Batch��$	 100�� �� $ BatchNo��� $
��Year��$	 100�� �� $
 Year��� $��Bangla Batch��$	 100�� �� $ BanglaBatch�