import 'package:ServiceRaju/common/models/api_response_model.dart';
import 'package:ServiceRaju/common/repo/data_sync_repo.dart';
import 'package:ServiceRaju/utils/core_export.dart';

class CampaignRepo extends DataSyncRepo {
  CampaignRepo(
      {required super.apiClient,
      required SharedPreferences super.sharedPreferences});

  Future<ApiResponseModel<T>> getCampaignList<T>(
      {required DataSourceEnum source}) async {
    return await fetchData<T>(AppConstants.campaignUri, source);
  }
}
