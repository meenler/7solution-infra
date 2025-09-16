#!/bin/bash
set -e

CHART_PATH="./charts/go-app"
OUTPUT_FILE="./base/rendered.yaml"

echo "🚀 Rendering Helm chart from $CHART_PATH ..."

# Render helm template แล้วส่งออกไป base/rendered.yaml
helm template go-app $CHART_PATH -f $CHART_PATH/values.yaml > $OUTPUT_FILE

echo "✅ Rendered Helm chart saved to $OUTPUT_FILE"
