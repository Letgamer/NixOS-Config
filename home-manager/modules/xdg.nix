{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/about" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "text/html" = ["firefox.desktop"];
      "application/pdf" = ["firefox.desktop"];
      "x-scheme-handler/discord" = ["discord.desktop"];

      # Windows
      "application/x-ms-dos-executable" = ["bottles.desktop"];
      "application/x-msi" = ["bottles.desktop"];
      "application/vnd.microsoft.portable-executable" = ["bottles.desktop"];

      # Images
      "image/jpeg" = ["firefox.desktop"];
      "image/png" = ["firefox.desktop"];
      "image/gif" = ["firefox.desktop"];
      "image/webp" = ["firefox.desktop"];
      "image/svg+xml" = ["firefox.desktop"];
      "image/bmp" = ["firefox.desktop"];
      "image/tiff" = ["firefox.desktop"];
      "image/avif" = ["firefox.desktop"];

      # Video
      "video/mp4" = ["firefox.desktop"];
      "video/webm" = ["firefox.desktop"];
      "video/x-matroska" = ["firefox.desktop"];
      "video/quicktime" = ["firefox.desktop"];
      "video/x-msvideo" = ["firefox.desktop"];

      # Audio
      "audio/mpeg" = ["firefox.desktop"];
      "audio/ogg" = ["firefox.desktop"];
      "audio/wav" = ["firefox.desktop"];
      "audio/webm" = ["firefox.desktop"];
      "audio/flac" = ["firefox.desktop"];

      # LibreOffice Writer
      "application/msword" = ["writer.desktop"];
      "application/vnd.ms-word" = ["writer.desktop"];
      "application/vnd.oasis.opendocument.text" = ["writer.desktop"];
      "application/vnd.oasis.opendocument.text-template" = ["writer.desktop"];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["writer.desktop"];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.template" = ["writer.desktop"];
      "application/vnd.ms-word.document.macroEnabled.12" = ["writer.desktop"];
      "application/vnd.ms-word.template.macroEnabled.12" = ["writer.desktop"];

      # LibreOffice Calc
      "text/csv" = ["calc.desktop"];
      "text/comma-separated-values" = ["calc.desktop"];
      "text/tab-separated-values" = ["calc.desktop"];
      "text/x-csv" = ["calc.desktop"];
      "application/csv" = ["calc.desktop"];
      "application/excel" = ["calc.desktop"];
      "application/msexcel" = ["calc.desktop"];
      "application/vnd.ms-excel" = ["calc.desktop"];
      "application/vnd.oasis.opendocument.spreadsheet" = ["calc.desktop"];
      "application/vnd.oasis.opendocument.spreadsheet-template" = ["calc.desktop"];
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = ["calc.desktop"];
      "application/vnd.openxmlformats-officedocument.spreadsheetml.template" = ["calc.desktop"];
      "application/vnd.ms-excel.sheet.binary.macroEnabled.12" = ["calc.desktop"];
      "application/vnd.ms-excel.sheet.macroEnabled.12" = ["calc.desktop"];
      "application/vnd.ms-excel.template.macroEnabled.12" = ["calc.desktop"];

      # LibreOffice Impress
      "application/vnd.ms-powerpoint" = ["impress.desktop"];
      "application/mspowerpoint" = ["impress.desktop"];
      "application/vnd.oasis.opendocument.presentation" = ["impress.desktop"];
      "application/vnd.oasis.opendocument.presentation-template" = ["impress.desktop"];
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = ["impress.desktop"];
      "application/vnd.openxmlformats-officedocument.presentationml.slide" = ["impress.desktop"];
      "application/vnd.openxmlformats-officedocument.presentationml.slideshow" = ["impress.desktop"];
      "application/vnd.openxmlformats-officedocument.presentationml.template" = ["impress.desktop"];
      "application/vnd.ms-powerpoint.presentation.macroEnabled.12" = ["impress.desktop"];
      "application/vnd.ms-powerpoint.slideshow.macroEnabled.12" = ["impress.desktop"];
      "application/vnd.ms-powerpoint.template.macroEnabled.12" = ["impress.desktop"];

      # LibreOffice Draw
      "application/vnd.oasis.opendocument.graphics" = ["draw.desktop"];
      "application/vnd.oasis.opendocument.graphics-template" = ["draw.desktop"];
      "application/vnd.visio" = ["draw.desktop"];
      "application/vnd.ms-publisher" = ["draw.desktop"];
      "application/vnd.corel-draw" = ["draw.desktop"];
    };
  };
}
