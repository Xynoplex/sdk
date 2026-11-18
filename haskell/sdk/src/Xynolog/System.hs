module Xynolog.System (SystemNamespace, newSystem, healthCheck, status) where

import Xynolog.Gateway qualified as Gateway
import Xynolog.Types

data SystemNamespace = SystemNamespace Gateway.GatewayOperations

newSystem :: Gateway.GatewayOperations -> SystemNamespace
newSystem = SystemNamespace

healthCheck :: SystemNamespace -> IO HealthResponse
healthCheck (SystemNamespace gateway) = Gateway.healthCheck gateway

status :: SystemNamespace -> IO StatusResponse
status (SystemNamespace gateway) = Gateway.getStatus gateway
