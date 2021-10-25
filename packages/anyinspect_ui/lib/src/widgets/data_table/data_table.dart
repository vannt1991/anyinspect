import 'package:flutter/material.dart' hide DataTable;

class _TableColumn extends StatelessWidget {
  final Widget label;

  const _TableColumn({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      constraints: const BoxConstraints(minHeight: 30),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 14),
      child: DefaultTextStyle(
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText2!.color!.withOpacity(0.6),
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        child: label,
      ),
    );
  }
}

class DataTable extends StatelessWidget {
  final List<int> initialColumnWeights;
  final List<DataColumn> columns;
  final List<DataRow> rows;

  const DataTable({
    Key? key,
    required this.initialColumnWeights,
    required this.columns,
    required this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              for (var i = 0; i < columns.length; i++)
                Expanded(
                  flex: initialColumnWeights[i],
                  child: _TableColumn(label: columns[i].label),
                ),
            ],
          ),
          Expanded(
            child: ListView(
              controller: ScrollController(),
              children: [
                for (var row in rows)
                  GestureDetector(
                    onTap: () {
                      row.onSelectChanged!(true);
                    },
                    child: Container(
                      constraints: BoxConstraints(minHeight: 32),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          for (var i = 0; i < row.cells.length; i++)
                            Expanded(
                              flex: initialColumnWeights[i],
                              child: Container(
                                padding: EdgeInsets.only(left: 14),
                                child: row.cells[i].child,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}