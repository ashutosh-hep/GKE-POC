import yaml
import json

def convert_ecs_to_gke(definition_file):
    deployment_yaml = {
        "apiVersion": "apps/v1",
        "kind": "Deployment",
        "metadata": {
            "name": definition_file["family"],
            "labels": {
                "app": definition_file["family"]
            }
        },
        "spec": {
            "replicas": 1,
            "selector": {
                "matchLabels": {
                    "app": definition_file["family"]
                }
            },
            "template": {
                "metadata": {
                    "labels": {
                        "app": definition_file["family"]
                    }
                },
                "spec": {
                    "containers": [
                        {
                            "name": container["name"],
                            "image": container["image"],
                            "resources": {
                                "limits": {
                                    "memory": (container.get("memory", "256Mi"))+"Gi",
                                    "cpu": container.get("cpu", "100m")
                                }
                            }
                        }
                        for container in definition_file["containerDefinitions"]
                    ]
                }
            }
        }
    }

    return deployment_yaml




def main():
    with open("sample_definition.json", "r") as ecs_file:
        definition_file = json.load(ecs_file)

    deployment_yaml = convert_ecs_to_gke(definition_file)

    with open("sample_deployment.yaml", "w") as gke_yaml:
        yaml.dump(deployment_yaml, gke_yaml, default_flow_style=False)

if __name__ == "__main__":
    main()
