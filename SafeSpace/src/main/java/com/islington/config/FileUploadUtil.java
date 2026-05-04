package com.islington.config;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;
import jakarta.servlet.http.Part;

public class FileUploadUtil {

    private static final String UPLOAD_SUBFOLDER = "safespace_uploads";
    public static final long MAX_FILE_SIZE = 25L * 1024L * 1024L;

    private static final Set<String> ALLOWED_MIME_TYPES = new HashSet<>();
    static {
        ALLOWED_MIME_TYPES.add("image/jpeg");
        ALLOWED_MIME_TYPES.add("image/png");
        ALLOWED_MIME_TYPES.add("image/gif");
        ALLOWED_MIME_TYPES.add("image/webp");
        ALLOWED_MIME_TYPES.add("image/heic");
        ALLOWED_MIME_TYPES.add("image/heif");
        ALLOWED_MIME_TYPES.add("video/mp4");
        ALLOWED_MIME_TYPES.add("video/webm");
        ALLOWED_MIME_TYPES.add("video/quicktime");
        ALLOWED_MIME_TYPES.add("video/x-msvideo");
        ALLOWED_MIME_TYPES.add("application/pdf");
        ALLOWED_MIME_TYPES.add("application/msword");
        ALLOWED_MIME_TYPES.add("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        ALLOWED_MIME_TYPES.add("text/plain");
    }

    public static File getUploadDirectory() {
        String userHome = System.getProperty("user.home");
        File dir = new File(userHome, UPLOAD_SUBFOLDER);
        if (!dir.exists()) dir.mkdirs();
        return dir;
    }

    public static boolean isAllowedMimeType(String mimeType) {
        if (mimeType == null) return false;
        return ALLOWED_MIME_TYPES.contains(mimeType.toLowerCase());
    }

    public static String extractExtension(String originalFilename) {
        if (originalFilename == null) return ".bin";
        int dot = originalFilename.lastIndexOf('.');
        if (dot < 0 || dot == originalFilename.length() - 1) return ".bin";
        String ext = originalFilename.substring(dot).toLowerCase();
        if (!ext.matches("\\.[a-z0-9]{1,8}")) return ".bin";
        return ext;
    }

    public static String saveUploadedFile(Part part, String originalFilename) throws IOException {
        String extension = extractExtension(originalFilename);
        String storedFilename = UUID.randomUUID().toString() + extension;
        File destFile = new File(getUploadDirectory(), storedFilename);
        Path destPath = Paths.get(destFile.getAbsolutePath());
        try (InputStream in = part.getInputStream()) {
            Files.copy(in, destPath, StandardCopyOption.REPLACE_EXISTING);
        }
        return storedFilename;
    }

    public static File getStoredFile(String storedFilename) {
        if (storedFilename == null || storedFilename.isEmpty()) return null;
        if (storedFilename.contains("..") || storedFilename.contains("/") || storedFilename.contains("\\")) return null;
        File file = new File(getUploadDirectory(), storedFilename);
        if (!file.exists() || !file.isFile()) return null;
        return file;
    }

    public static String extractFilename(Part part) {
        if (part == null) return null;
        String name = part.getSubmittedFileName();
        if (name != null && !name.isEmpty()) {
            int slash = Math.max(name.lastIndexOf('/'), name.lastIndexOf('\\'));
            if (slash >= 0) name = name.substring(slash + 1);
            return name;
        }
        String cd = part.getHeader("content-disposition");
        if (cd == null) return null;
        for (String token : cd.split(";")) {
            token = token.trim();
            if (token.startsWith("filename=")) {
                String filename = token.substring(9).replace("\"", "");
                int slash = Math.max(filename.lastIndexOf('/'), filename.lastIndexOf('\\'));
                if (slash >= 0) filename = filename.substring(slash + 1);
                return filename;
            }
        }
        return null;
    }
}