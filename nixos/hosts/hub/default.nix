{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  
  # ===== host =====
  networking.hostName = "hub";

  # ===== groups =====
  users.groups.hub = {};

  users.users.weis.extraGroups = [
    "hub"
  ];

  # ===== data mount disk =====
  fileSystems."/data" = {
    device = "/dev/disk/by-label/DATA";
    fsType = "ext4";
    options = [
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noatime"
    ];
  };

  # ===== Firewall Ports =====
  networking.firewall.allowedTCPPorts = [
    2283 # Immich
    5055 # Seerr
    7878 # Radarr
    8080 # qBittorrent
    8096 # Jellyfin
    8989 # Sonarr
    9696 # Prowlarr
    8000 # Paperless-ngx
    22000 # syncthing
  ];

  # ===== data Home link =====
  systemd.tmpfiles.rules = [
    "d /data 2775 weis hub - -"

    "d /data/documents 2775 weis hub - -"
    "d /data/downloads 2775 weis hub - -"
    "d /data/pictures 2775 weis hub - -"
    "d /data/music 2775 weis hub - -"

    "d /data/videos 2775 weis hub - -"
    "d /data/videos/movies 2775 weis hub - -"
    "d /data/videos/tv 2775 weis hub - -"

    "d /data/shared 2775 weis hub - -"
    "d /data/backups 2770 weis hub - -"
    "d /data/.secrets 2770 weis hub - -"

    "L+ /home/weis/Documents - - - - /data/documents"
    "L+ /home/weis/Downloads - - - - /data/downloads"
    "L+ /home/weis/Pictures - - - - /data/pictures"
    "L+ /home/weis/Music - - - - /data/music"
    "L+ /home/weis/Videos - - - - /data/videos"
  ];

  # ===== Docker network =====
  systemd.services.docker-network-hub = {
    description = "Create Docker network: hub";

    wantedBy = [ "multi-user.target" ];
    after = [ "docker.service" ];
    requires = [ "docker.service" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      ${pkgs.docker}/bin/docker network inspect hub >/dev/null 2>&1 \
        || ${pkgs.docker}/bin/docker network create hub
    '';
  };
}
