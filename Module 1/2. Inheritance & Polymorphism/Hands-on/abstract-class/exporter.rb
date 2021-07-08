class GenericExporter
    def export
        raise NotImplementedError, 'You must implement the export method'
    end
end

class PdfExporter < GenericExporter
    def export
        puts 'Export to .pdf format'
    end
end

class XlsExporter < GenericExporter
    def export
        puts "Export to .xls format"
    end
end