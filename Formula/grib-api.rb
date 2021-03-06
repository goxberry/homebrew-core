class GribApi < Formula
  desc "Encode and decode grib messages (editions 1 and 2)"
  homepage "https://software.ecmwf.int/wiki/display/GRIB/Home"
  url "https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-1.16.0-Source.tar.gz"
  sha256 "0068ca4149a9f991d4c86a813ac73b4e2299c6a3fd53aba9e6ab276ef6f0ff9a"

  bottle do
    revision 1
    sha256 "036c3b51c4fd1b395621a203f6371e49e5556fd4f5d57406387d177d694f6f93" => :el_capitan
    sha256 "99812f0ed49d23691574e0ca6848e9b4565576c252df94d92a402e1830729359" => :yosemite
    sha256 "fa86bc7113fe94511e8c7d126e8ba34b0523feff0b71c35ca023e6c20e327ab4" => :mavericks
  end

  option "with-static", "Build static instead of shared library."

  depends_on :fortran
  depends_on "cmake" => :build
  depends_on "jasper" => :recommended
  depends_on "libpng" => :optional

  # Fixes build errors in Lion
  # https://software.ecmwf.int/wiki/plugins/viewsource/viewpagesrc.action?pageId=12648475
  patch :DATA

  def install
    mkdir "build" do
      args = std_cmake_args
      args << "-DBUILD_SHARED_LIBS=OFF" if build.with? "static"
      args << "-DPNG_PNG_INCLUDE_DIR=#{Formula["libpng"].opt_include}" << "-DENABLE_PNG=ON" if build.with? "libpng"
      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    grib_samples_path = shell_output("#{bin}/grib_info -t").strip
    system "#{bin}/grib_ls", "#{grib_samples_path}/GRIB1.tmpl"
    system "#{bin}/grib_ls", "#{grib_samples_path}/GRIB2.tmpl"
  end
end

__END__
diff --git a/configure b/configure
index 0a88b28..9dafe46 100755
--- a/configure
+++ b/configure
@@ -7006,7 +7006,7 @@ $as_echo_n "checking for $compiler option to produce PIC... " >&6; }
     darwin* | rhapsody*)
       # PIC is the default on this platform
       # Common symbols not allowed in MH_DYLIB files
-      lt_prog_compiler_pic='-fno-common'
+      #lt_prog_compiler_pic='-fno-common'
       ;;
 
     hpux*)
@@ -12186,7 +12186,7 @@ $as_echo_n "checking for $compiler option to produce PIC... " >&6; }
     darwin* | rhapsody*)
       # PIC is the default on this platform
       # Common symbols not allowed in MH_DYLIB files
-      lt_prog_compiler_pic_F77='-fno-common'
+      #lt_prog_compiler_pic_F77='-fno-common'
       ;;
 
     hpux*)
@@ -15214,7 +15214,7 @@ $as_echo_n "checking for $compiler option to produce PIC... " >&6; }
     darwin* | rhapsody*)
       # PIC is the default on this platform
       # Common symbols not allowed in MH_DYLIB files
-      lt_prog_compiler_pic_FC='-fno-common'
+      #lt_prog_compiler_pic_FC='-fno-common'
       ;;
 
     hpux*)
