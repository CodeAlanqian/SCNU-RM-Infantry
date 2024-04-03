# SCNU-RM-Infantry

华南师范大学VANGUARD战队步兵视觉代码
基于陈君的rm_vision

## docker 部署

导入image

```bash
sudo docker load -i scnu-rv-infantry.tar
```

构建开发容器

```bash
sudo docker run -it --name rv_devel \
--privileged --network host \
-v /dev:/dev -v ~/ws:/SCNU-RM-Infantry \
scnu-rv-infantry:latest \
ros2 launch foxglove_bridge foxglove_bridge_launch.xml
```

构建运行容器

```bash
sudo docker run -it --name rv_runtime \
--privileged --network host --restart always \
-v /dev:/dev -v ~/ws:/SCNU-RM-Infantry \
scnu-rv-infantry:latest \
ros2 launch rm_vision_bringup vision_bringup.launch.py
```
