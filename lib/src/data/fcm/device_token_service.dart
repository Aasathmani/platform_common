class DeviceTokenService {
  /* Future<void> registerToken({
    required String cdcNumber,
    required String token,
  }) async {
    final result = await graphMutate(
      MutationOptions(
        document: gql(_registerTokenMutation),
        variables: {
          'cdc_number': cdcNumber,
          'device_token': token,
        },
      ),
      clientType: GraphQLClientType.seafarer,
    );

    if (result.hasException) {
      throw CustomException.fromGraph(
        'REGISTER_TOKEN_FAILED',
        result.exception.graphqlErrors,
      );
    }
  }

  Future<void> deRegisterToken({
    required String token,
  }) async {
    final result = await graphMutate(
      MutationOptions(
        document: gql(_deRegisterTokenMutation),
        variables: {
          'device_token': token,
        },
      ),
      clientType: GraphQLClientType.seafarer,
    );

    if (result.hasException) {
      throw CustomException.fromGraph(
        'DE-REGISTER_TOKEN_FAILED',
        result.exception.graphqlErrors,
      );
    }
  }*/

  static const _registerTokenMutation = r'''
  mutation create_push_notification_device_arn($cdc_number: String!, $device_token: String!) {
    create_push_notification_device_arn(cdc_number: $cdc_number, device_token: $device_token) {
      id
    }
  }
  ''';

  static const _deRegisterTokenMutation = r'''
  mutation delete_push_notification_device_arn($device_token: String!) {
    delete_push_notification_device_arn(device_token: $device_token) {
      id
    }
  }
  ''';
}
