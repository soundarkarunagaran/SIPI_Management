   M S B A M L   `   `   `  ����   SIPI_SL9    3SIPI_SL.UI.ResultManagement.CourseAssignToStudentUI   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35n jSAPBusinessObjects.WPF.ViewerShared, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml       � Title$!  Course Assign To Student UI��$��774.781��$��1247.231�� � WindowState$ 	Maximized=� � WindowStartupLocation$ CenterScreen=� � 
ResizeMode$ CanMinimize=�   	GrayWhite#��[   � ShowInTaskbar .  .��� .+��� $��Student Assign��$��Center=�$��
28,10,10,0q�$	��Top=�$
��1203��$	��687��.��� .+��� -   $��departmentCombobox��$
��Left=�$��	95,14,0,0q�$	��Top=�$	��254��  ComboBoxBGYellowGreen#��[ �� $��
Department��$
��Left=�$��7,22,0,0q�$	��Top=�$��79���� -   $��semesterCombobox��$
��Left=�$��
459,14,0,0q�$	��Top=�$	��184��#��[ �� $��Current Semester��$
��Left=�$��
354,14,0,0q�$	��Top=�$	��105���� -   $��yearCombobox��$
��Left=�$��	95,54,0,0q�$	��Top=�$	��254��#��[ �� $
��Year��$
��Left=�$��	10,53,0,0q�$	��Top=�$��41���� -   $��searchButton��$�� ��$
��Left=�$��
524,58,0,0q�$	��Top=�$	��119��$��27��  SearchButton#���  �� -   $��assignButton��$��Assign��$
��Left=�$��1073,313,0,0q�$	��Top=�$	��108��$��36��&   System.Windows.Controls.DataGrid  -   $��studentListDataGrid��   AutoGenerateColumns .  $	��561��$
��Left=�$��	10,90,0,0q�$	��Top=�$	��633��   CanUserAddRows .     Columns 0  *System.Windows.Controls.DataGridTextColumn  ,  &System.Windows.Controls.DataGridColumn   Header$ 
Department��	   Width5  /System.Windows.Controls.DataGridLengthConverter$
	 auto 
   
IsReadOnly
 . 1  +System.Windows.Controls.DataGridBoundColumn   Binding ��  �� Path$ SIPI_Department�  $ Semester��$
	 auto 
 .  �� $ 
SemesterNo�  $ Student Name��$
	 auto 
 .  �� $ ApplicantName�  $ 
Srudent Id��$
	 auto 
 .  �� $ 	StudentId�4  .System.Windows.Controls.DataGridTemplateColumn  
 .  �� -   $��CheckALL��$��
Select All��{�.     CellTemplate �� .R��� $��chkDiscontinue��-   $��45 2 0 0q� d� 	IsChecked �� *	IsChecked+ �� ElementName$ CheckALL�� �� Mode$ OneWay=�  -	   $��CourseListDataGrid�� .  $	��219��$��
648,93,0,0q�$	��Top=� .  $
��Left=�$	��533��   $ 
Department��$
	 auto 
 .  �� $ DepartmentName�  $ Semester��$
	 auto 
 .  �� $ 
SemesterNo�  $ Course Name��$
	 auto 
 .  �� $ 
CourseName�  $ Course Code��$
	 auto 
 .  �� $ 
CourseCode�  $ Total Marks��$
	 auto 
 .  �� $ TotalCredit�  $ Total Marks��$
	 auto 
 .  �� $ 
TotalMarks��� -
   $��semesterAssignCmbBox��$
��Left=�$��1025,54,0,0q�$	��Top=�$	��156��#��[ �� $��Assign to Semester Course��$
��Left=�$��
864,54,0,0q�$	��Top=�$	��156���� -   $��assignStudent��$	��300��$
��Left=�$��648,351,0,0q�$	��Top=�$	��533�� � ContextMenu �� -   $��contextformationList�� �� 	StaysOpen . 
������� J� BitmapEffect �� .@�m� -   $��RemoveZoneInfoContextMenu��$��Remove�� �� View �� .P��� $��Id�� �� Width$ 0�� �� DisplayMemberBinding �� $ ZoneBranchId��� $��
DEpartment��$
 auto�� �� $ DepartmentName��� $
��YEAR��$
 Auto�� �� $ YearNo��� $��SEMESTER��$
 auto�� �� $ 
SemesterNo�