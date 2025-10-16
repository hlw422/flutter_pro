import 'package:flutter/material.dart';

/// 通用表格组件（带删除功能）
/// [columns]：列配置列表（包含表头名称、数据字段、单元格样式等）
/// [dataList]：表格数据列表（每个元素是 Map<String, dynamic>，key 对应字段名，value 对应字段值）
/// [onRowTap]：行点击回调（可选，返回当前行数据）
/// [onDelete]：删除行回调（可选，返回要删除的行数据和索引）
/// [nameField]：用于显示在删除提示中的名称字段（默认使用'name'字段）
class CommonDataTable extends StatelessWidget {
  // 列配置模型（单个列的配置）
  final List<CommonTableColumn> columns;
  // 表格数据（Map 格式，key 是字段名，value 是字段值）
  final List<Map<String, dynamic>> dataList;
  // 行点击事件（可选）
  final Function(Map<String, dynamic>)? onRowTap;
  // 删除行事件（可选）
  final Function(Map<String, dynamic>, int)? onDelete;
  // 表格边框样式（可选，默认灰色细边框）
  final TableBorder? border;
  // 列间距（可选，默认 20）
  final double columnSpacing;
  // 是否显示删除列（默认显示，当onDelete不为null时有效）
  final bool showDeleteColumn;
  // 删除列标题（默认"操作"）
  final String deleteColumnTitle;
  // 用于显示在删除提示中的名称字段（默认使用'name'）
  final String nameField;

  const CommonDataTable({
    super.key,
    required this.columns,
    required this.dataList,
    this.onRowTap,
    this.onDelete,
    this.border,
    this.columnSpacing = 20,
    this.showDeleteColumn = true,
    this.deleteColumnTitle = "操作",
    this.nameField = 'name', // 默认使用'name'字段作为名称
  });

  @override
  Widget build(BuildContext context) {
    // 构建完整的列列表（包含用户定义的列 + 可能的删除列）
    final List<CommonTableColumn> allColumns = List.from(columns);
    
    // 如果提供了删除回调且需要显示删除列，则添加删除列
    if (onDelete != null && showDeleteColumn) {
      allColumns.add(
        CommonTableColumn(
          title: deleteColumnTitle,
          field: '_delete', // 特殊字段名，不会与用户数据冲突
          cellBuilder: (_, rowData) {
            // 获取当前行的索引
            final index = dataList.indexOf(rowData);
            return IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 18),
              onPressed: () => _showDeleteConfirmation(context, rowData, index),
              tooltip: "删除",
            );
          },
          cellPadding: const EdgeInsets.symmetric(vertical: 4),
        ),
      );
    }

    return SingleChildScrollView(
      // 横向滚动，解决列数多导致的宽度溢出
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: border ??
            TableBorder.all(
              color: Colors.grey.shade300,
              width: 1,
              style: BorderStyle.solid,
            ),
        columnSpacing: columnSpacing,
        // 1. 构建表头（从 columns 参数解析）
        columns: allColumns.map((column) {
          return DataColumn(
            label: Text(
              column.title,
              style: column.headerTextStyle ??
                  const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
            ),
            // 表头提示（可选）
            tooltip: column.tooltip,
            // 数值型列右对齐（可选）
            numeric: column.isNumeric ?? false,
          );
        }).toList(),
        // 2. 构建表格行（从 dataList 参数解析）
        rows: dataList.map((rowData) {
          return DataRow(
            // 行点击事件
            onSelectChanged: onRowTap != null
                ? (isSelected) => onRowTap!(rowData)
                : null,
            // 构建行的单元格（与列配置一一对应）
            cells: allColumns.map((column) {
              // 获取当前单元格对应的数据（根据 column.field 从 rowData 中取）
              final cellValue = rowData[column.field];
              // 自定义单元格内容（优先用 column 的 cellBuilder，没有则显示默认文本）
              final cellContent = column.cellBuilder?.call(cellValue, rowData) ??
                  Text(
                    _formatCellValue(cellValue), // 格式化数据显示（处理 null/特殊类型）
                    style: column.cellTextStyle ?? const TextStyle(fontSize: 13),
                  );

              return DataCell(
                // 单元格内边距（可选）
                Padding(
                  padding: column.cellPadding ?? const EdgeInsets.symmetric(vertical: 8),
                  child: cellContent,
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  /// 显示删除确认对话框（包含数据名称提示）
  void _showDeleteConfirmation(
    BuildContext context,
    Map<String, dynamic> rowData,
    int index,
  ) {
    // 获取要删除的数据名称
    final itemName = rowData[nameField] ?? '这条数据';
    // 格式化名称显示
    final displayName = _formatCellValue(itemName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("确认删除"),
        content: Text("确定要删除 [ $displayName ] 吗？此操作不可撤销。"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("取消"),
          ),
          TextButton(
            onPressed: () {
              // 关闭对话框
              Navigator.of(context).pop();
              // 调用删除回调
              onDelete?.call(rowData, index);
            },
            child: const Text(
              "删除",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  /// 格式化单元格值（处理 null、数字、布尔值等）
  String _formatCellValue(dynamic value) {
    if (value == null) return "—"; // null 显示占位符
    if (value is bool) return value ? "是" : "否"; // 布尔值转中文
    if (value is DateTime) return value.toString().substring(0, 16); // 日期格式化（只显示年月日时分）
    return value.toString(); // 其他类型直接转字符串
  }
}

/// 通用表格列配置模型（单个列的详细配置）
class CommonTableColumn {
  // 表头名称（必传）
  final String title;
  // 数据字段名（必传，对应 dataList 中 Map 的 key）
  final String field;
  // 表头提示（可选）
  final String? tooltip;
  // 是否数值型（数值型会右对齐，可选）
  final bool? isNumeric;
  // 表头文本样式（可选）
  final TextStyle? headerTextStyle;
  // 单元格文本样式（可选）
  final TextStyle? cellTextStyle;
  // 单元格内边距（可选）
  final EdgeInsetsGeometry? cellPadding;
  // 自定义单元格构建器（可选，支持复杂样式，如状态标签、图标等）
  final Widget Function(dynamic cellValue, Map<String, dynamic> rowData)? cellBuilder;

  CommonTableColumn({
    required this.title,
    required this.field,
    this.tooltip,
    this.isNumeric,
    this.headerTextStyle,
    this.cellTextStyle,
    this.cellPadding,
    this.cellBuilder,
  });
}
    