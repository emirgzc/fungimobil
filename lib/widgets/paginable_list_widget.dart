import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../constants/handle_exceptions.dart';
import '../constants/style.dart';
import '../model/table_model.dart' as table;
import '../viewmodel/table_view_model.dart';
import 'loading_widget.dart';

class PaginableList extends StatefulWidget {
  PaginableList({
    Key? key,
    required this.tableName,
    this.pageLimit = 10,
    this.filter = const {},
    required this.itemBuilder,
    this.useShimmerEffectFormat = false,
    this.shimmerLoadingLength = 5,
    this.scrollController,
  }) : super(key: key);

  String tableName;
  int pageLimit;
  Map<String, dynamic> filter;

  /// shimmerEffect true ise data null gelebilir, false durumunda her zaman data dolu olacaktır.
  Widget Function(BuildContext context, Map<String, dynamic>? data) itemBuilder;

  /// veriler üzerine shimmer effect uygulanıyormu
  bool useShimmerEffectFormat;

  /// shimmer effect kullanılacaksa en baştaki shimmer item sayısı
  int shimmerLoadingLength;

  /// listView'da [shrinkWrap=true] kullanılacaksa parent scrollView'ın controller'ı verilir
  ScrollController? scrollController;

  @override
  State<PaginableList> createState() => _PaginableListState();
}

class _PaginableListState extends State<PaginableList> {
  TableViewModel? provider;
  table.TableModel? _tableModel;
  ScrollController? _scrollController;
  bool isPaginationLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.scrollController == null) {
      _scrollController = ScrollController();
      _scrollController!.addListener(_pagination);
    } else {
      widget.scrollController!.addListener(_pagination);
    }
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    provider ??= Provider.of<TableViewModel>(context);
    return _tableModel == null && !widget.useShimmerEffectFormat
        ? const LoadingWidget()
        : FutureBuilder<table.TableModel?>(
            future: _listenTable(context),
            builder: (context, snapshot) {
              if ((snapshot.hasData && snapshot.data != null) || widget.useShimmerEffectFormat) {
                _tableModel = snapshot.data;
                return Stack(
                  children: [
                    ListView.separated(
                      key: const PageStorageKey(0),
                      controller: widget.scrollController == null ? _scrollController : null,
                      shrinkWrap: widget.scrollController == null,
                      physics: widget.scrollController != null ? const NeverScrollableScrollPhysics() : null,
                      itemCount: _tableModel?.data?.length ??
                          (widget.useShimmerEffectFormat ? widget.shimmerLoadingLength : 0),
                      padding: Style.defaultPagePadding,
                      itemBuilder: (context, index) {
                        return widget.itemBuilder(context, _tableModel?.data?[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: Style.defaultPadding / 3),
                          height: 1,
                          width: double.infinity,
                          color: Style.secondaryColor.withOpacity(0.2),
                        );
                      },
                    ),
                    if (isPaginationLoading) _buildPageLoadingWidget(context),
                  ],
                );
              } else if (snapshot.hasError && snapshot.error != null) {
                HandleExceptions.handle(exception: snapshot.error, context: context);
              }

              return const LoadingWidget();
            });
  }

  Align _buildPageLoadingWidget(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 0.075.sh,
        width: double.infinity,
        decoration: BoxDecoration(
            // color: Colors.red,
            gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [
          Theme.of(context).scaffoldBackgroundColor,
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0)
        ])),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Style.defaultPadding * 2),
            child: LinearProgressIndicator(
                color: Style.secondaryColor, backgroundColor: Style.secondaryColor.withOpacity(0.1)),
          ),
        ),
      ),
    );
  }

  Future<table.TableModel> _fetchData(BuildContext context) async {
    _tableModel = await Provider.of<TableViewModel>(context, listen: false).fetchTable(
      tableName: widget.tableName,
      page: 1,
      limit: widget.pageLimit,
      filter: widget.filter,
    );
    return _tableModel!;
  }

  Future<table.TableModel?> _listenTable(BuildContext context) async {
    return await Provider.of<TableViewModel>(context).listenTable();
  }

  void _pagination() {
    if (_tableModel == null) {
      return;
    }
    int currentPage = (_tableModel!.data!.length.toDouble() / widget.pageLimit.toDouble()).ceil();
    bool hasMore = _tableModel!.count! > _tableModel!.data!.length;

    bool isMaxScroll = widget.scrollController == null
        ? (_scrollController!.position.pixels == _scrollController!.position.maxScrollExtent)
        : (widget.scrollController!.position.pixels == widget.scrollController!.position.maxScrollExtent);

    if (isMaxScroll && _tableModel != null && hasMore) {
      _changePageTableData(currentPage);
    }
  }

  Future<table.TableModel?> _changePageTableData(int currentPage) async {
    setState(() {
      isPaginationLoading = true;
    });
    return await Provider.of<TableViewModel>(context, listen: false)
        .changePageTableData(
            tableName: widget.tableName, page: currentPage + 1, limit: widget.pageLimit, filter: widget.filter)
        .then((value) {
      setState(() {
        isPaginationLoading = false;
      });
      return null;
    });
  }
}
