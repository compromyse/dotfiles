{ config, lib, pkgs, ... }:

{
  users.users.www = {
    isNormalUser = false;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDljZ44cNtYqvpeGuUsMRekkjiyaCLraX7GHp2BJGyhvUnCpVz7I5K6SGQ92vnEdkbQpUEs29Cw5RTYTKDXcn1zyl7fi/jLWVLgV3Apc7dbJvhQOTfxB24D5EuOR+3nZFtR1C89VNiB55ahqoBAxGMxr9GkOaKplruT1u+UOAW7wRwCGWoC7ySuVRnEoquWsv3ZHZhxTgmM6b8wnOk9K/to0JY51fbZ56OXcUKRUNkq4QzVMWEhWEpOuSFeufOewCjUIcMQkWzjG3XiqF7gBGnNqbvPlWOB3iLbAdOGBfkAxFlzTBGzwNEGWV39AMWHA1dRBKeETo5sHACsorpIQ3IHR3uHz3YccqhzOBqERqU419ioLdHSQt7uXS54AvZ7ZAMm/RZBeFdupT2dhfOdmvY/2ZHHEuP55A3GExlthaFR+SPKc1q/MhtX/+hBhtkPH+RMP/WPgPbXBCLVdL/ul/vGk8CGCFeKAVrexmz5q+5xax/gDIKfS3ynoMCrWxoto2U= raghus2247@gmail.com"
    ];
  };
}
