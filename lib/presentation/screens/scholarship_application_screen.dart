import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tneapp/config/constants/colores.dart';

class ScholarshipApplicationScreen extends StatefulWidget {
  final String scholarshipName;
  const ScholarshipApplicationScreen({super.key, required this.scholarshipName});

  @override
  State<ScholarshipApplicationScreen> createState() => _ScholarshipApplicationScreenState();
}

class _ScholarshipApplicationScreenState extends State<ScholarshipApplicationScreen> {
  bool _consentChecked = false;
  bool _isUploading = false;
  final List<String> _attachedFiles = [];

  void _simulateFileUpload() {
    setState(() => _isUploading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isUploading = false;
          _attachedFiles.add('Certificado_Alumno_Regular.pdf');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              backgroundColor: Colors.white.withOpacity(0.8),
              elevation: 0,
              scrolledUnderElevation: 0,
              title: const Text(
                'Postulación',
                style: TextStyle(
                  color: AppColors.textMain,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textMain, size: 20),
                onPressed: () => context.pop(),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, kToolbarHeight + 80, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.scholarshipName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Completa los datos para finalizar tu postulación al proceso 2025.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
            ),
            const SizedBox(height: 32),

            // Read-only Info
            _buildReadOnlyField('RUT del Postulante', '18.452.103-K'),
            const SizedBox(height: 16),
            _buildReadOnlyField('Número de Serie TNE', '982.103.456'),
            
            const SizedBox(height: 32),
            const Text(
              'Documentación Requerida',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
            const SizedBox(height: 12),
            
            // File Upload Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  if (_attachedFiles.isEmpty) ...[
                    const Icon(Icons.cloud_upload_outlined, size: 48, color: AppColors.primaryBlue),
                    const SizedBox(height: 12),
                    const Text(
                      'Adjunta tu Certificado de Alumno Regular',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Formato PDF, máx 5MB',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                  ] else ...[
                    ..._attachedFiles.map((file) => ListTile(
                      leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                      title: Text(file, style: const TextStyle(fontSize: 14)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: AppColors.textTertiary),
                        onPressed: () => setState(() => _attachedFiles.remove(file)),
                      ),
                    )),
                  ],
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _isUploading ? null : _simulateFileUpload,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primaryBlue),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: _isUploading 
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('SELECCIONAR ARCHIVO'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            
            // Consent Section
            Row(
              children: [
                Checkbox(
                  value: _consentChecked,
                  onChanged: (val) => setState(() => _consentChecked = val ?? false),
                  activeColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                const Expanded(
                  child: Text(
                    'Consiento que mis datos personales sean utilizados para la validación de esta postulación según la ley 19.628.',
                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            
            // Finalize Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: (_consentChecked && _attachedFiles.isNotEmpty) 
                  ? () => context.push('/application-success') 
                  : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AppColors.primaryBlue.withOpacity(0.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text(
                  'FINALIZAR POSTULACIÓN',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textTertiary,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Row(
          children: [
            Icon(Icons.lock_outline, size: 12, color: AppColors.textTertiary),
            SizedBox(width: 4),
            Text(
              'Dato protegido y no editable',
              style: TextStyle(fontSize: 11, color: AppColors.textTertiary),
            ),
          ],
        ),
      ],
    );
  }
}
